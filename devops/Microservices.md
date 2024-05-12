# Dotnet Microservices

## Project Instructions

```Powershell

dotnet new webapi -f 5.0 -lang "C#" -au "Windows"
dotnet new xunit -f 5.0 -lang "C#"
dotnet sln add Software.API/Software.API.csproj

dotnet add package AspNetCore.HealthChecks.UI.Client --version 5.0.1
dotnet add package AspNetCore.HealthChecks.Rabbitmq --version 5.0.1
dotnet add package System.Data.SqlClient --version 4.8.2

Test-NetConnection -ComputerName RABBITMQServerName -Port 5672

```

## References

- [Health Monitoring](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/monitor-app-health)
- [Health Check walk through](https://www.hanselman.com/blog/how-to-set-up-aspnet-core-22-health-checks-with-beatpulses-aspnetcorediagnosticshealthchecks)
