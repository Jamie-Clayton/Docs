# Microservices Architecture - .NET/C#

> **Document Type:** Explanation | **Related how-to:** [Azure Pipelines](AzurePipelines.md) | **Related reference:** [Containers and Service Fabric](Containers-ServiceFabric.md)

## Learning Objectives

After reading this document, you will understand:
- What microservices are and when to use them
- The key characteristics and trade-offs of microservices
- How to build a microservice in .NET with health checks
- Resilience patterns: health checks, circuit breakers, retries

## What are Microservices?

Microservices is an architectural style where a large application is decomposed into small, independent services that communicate over the network. Each service owns its data, deploys independently, and focuses on a specific business capability.

**Traditional Monolith:** One application, one database, one deployment  
**Microservices:** Many small applications, many databases, independent deployments

## When to Use Microservices

**Good fit:**
- Large teams working on different features (each team owns a service)
- Services have vastly different scaling needs (search service needs 10 instances, auth needs 2)
- Services are built with different technology stacks
- You need independent deployment cycles (feature team ships weekly, payment team ships monthly)

**Not a good fit:**
- Small teams or startups (operational overhead is high)
- Services are tightly coupled or share data constantly
- You don't have observability and monitoring infrastructure

**Rule of thumb:** Start with a monolith. Decompose to microservices only when a specific pain point demands it (scaling, team coordination, deployment frequency).

## Key Characteristics

- **Independently deployable:** Service A can deploy without affecting Service B
- **Loosely coupled:** Services communicate via APIs or message queues, not shared databases
- **Data isolation:** Each service owns its database; no cross-service queries
- **Failure isolation:** Service A failing doesn't crash Service B (but plan for it to be unavailable)
- **Autonomous teams:** One team owns end-to-end: code, test, deploy, monitor

## Challenges (Be Aware)

1. **Network latency and failures** - Remote calls fail; local calls never do
2. **Data consistency** - No transactions across services; embrace eventual consistency
3. **Operational complexity** - Monitoring, logging, and debugging are harder across services
4. **Testing complexity** - Integration testing requires spinning up multiple services

## Building Microservices in .NET

### Project Setup

```powershell
# Create API service
dotnet new webapi -f net6.0 -lang "C#" -au "Windows"

# Create unit test project
dotnet new xunit -f net6.0 -lang "C#"

# Add to solution
dotnet sln add Software.API/Software.API.csproj

# Add health check packages
dotnet add package AspNetCore.HealthChecks.UI.Client --version 6.0.0
dotnet add package AspNetCore.HealthChecks.RabbitMQ --version 6.0.0
dotnet add package AspNetCore.HealthChecks.SqlServer --version 6.0.0

# Add data access
dotnet add package System.Data.SqlClient --version 4.8.5
```

### Health Checks (Critical for Microservices)

Health checks allow orchestrators (Kubernetes, Docker Compose) to know if a service is healthy and route traffic accordingly.

```csharp
// In Program.cs
services
    .AddHealthChecks()
    .AddSqlServer("Server=localhost;Database=mydb;User Id=sa;Password=P@ssw0rd")
    .AddRabbitMQ("amqp://guest:guest@localhost/");

app.MapHealthChecks("/health");
```

### Verification

Test connectivity to dependent services before deploying:

```powershell
# Test RabbitMQ connectivity
Test-NetConnection -ComputerName RABBITMQ_HOSTNAME -Port 5672

# Test SQL Server connectivity
Test-NetConnection -ComputerName SQL_SERVER_HOSTNAME -Port 1433
```

### Inter-Service Communication

**Synchronous (HTTP/REST):** Request-response; simple but creates tight coupling and cascading failures.

```csharp
var client = new HttpClient();
var response = await client.GetAsync("https://inventory-service/api/stock/123");
```

**Asynchronous (Message Queue):** Fire and forget; decouples services but requires eventual consistency.

```csharp
// Publish event
await _messageBus.PublishAsync(new OrderCreatedEvent { OrderId = 123 });

// Subscribe in another service
public class OrderEventHandler : IEventHandler<OrderCreatedEvent>
{
    public async Task Handle(OrderCreatedEvent @event) 
    {
        // Update inventory based on order
    }
}
```

**Best practice:** Use async messaging for cross-service events; sync HTTP only for queries with tight SLA.

## Service Discovery

In a microservices environment, services move (IP changes, scale up/down). Services must discover each other dynamically.

**Kubernetes:** Built-in via DNS names (`http://payment-service.default.svc.cluster.local`)  
**Docker Compose:** Service names are resolved via embedded DNS  
**Manual:** Service registry (Consul, Eureka) or config server

## Resilience Patterns

Your service will call other services that will be slow or unavailable. Plan for it.

### Timeout
Every external call must have a timeout to prevent hanging requests.

```csharp
var client = new HttpClient();
client.Timeout = TimeSpan.FromSeconds(5);
var response = await client.GetAsync("https://external-service/api/data");
```

### Retry with Exponential Backoff
Transient failures should retry, not fail immediately.

```csharp
var policy = Policy
    .Handle<HttpRequestException>()
    .WaitAndRetryAsync(
        retryCount: 3,
        sleepDurationProvider: attempt => 
            TimeSpan.FromSeconds(Math.Pow(2, attempt))
    );

await policy.ExecuteAsync(async () => 
    await client.GetAsync("https://external-service/api/data")
);
```

### Circuit Breaker
If a service is failing consistently, stop calling it temporarily to prevent cascading failures.

```csharp
var policy = Policy
    .Handle<HttpRequestException>()
    .CircuitBreakerAsync(
        handledEventsAllowedBeforeBreaking: 5,
        durationOfBreak: TimeSpan.FromSeconds(30)
    );
```

## Monitoring Microservices

With multiple services, logging and monitoring become critical.

### Structured Logging

Log as JSON so you can search and correlate across services.

```csharp
builder.Services.AddSerilog(config => 
    config.WriteTo.Console(new JsonFormatter())
);

_logger.LogInformation("Order created: {@Order}", order);
```

### Distributed Tracing

Trace a single request as it flows through multiple services using a correlation ID.

```csharp
// Middleware to add correlation ID to all requests
app.Use(async (context, next) =>
{
    var correlationId = context.Request.Headers.TryGetValue("X-Correlation-ID", out var id) 
        ? id.ToString() 
        : Guid.NewGuid().ToString();
    
    using (LogContext.PushProperty("CorrelationId", correlationId))
    {
        await next.Invoke();
    }
});
```

### Key Metrics

Collect these metrics per service:

- **Latency:** p50, p95, p99 response times
- **Throughput:** Requests per second
- **Error rate:** % of requests that fail
- **Saturation:** CPU, memory, disk, database connections
- **Business metrics:** Orders/hour, signups/day, revenue/month

## References

- [Health Monitoring](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/monitor-app-health)
- [ASP.NET Core Health Checks](https://www.hanselman.com/blog/how-to-set-up-aspnet-core-22-health-checks-with-beatpulses-aspnetcorediagnosticshealthchecks)
- [Building Microservices with .NET](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/)
- [Release It! by Michael T. Nygard](https://pragprog.com/titles/mnee2/release-it-second-edition/)
- [Polly: Resilience and transient-fault-handling library](https://github.com/App-vNext/Polly) 
