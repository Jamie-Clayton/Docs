---
title: Production Ready Software
date: 2020-08-24 09:00:00 +1000
categories: [Explanation, Engineering]
tags: [production, reliability, quality]
author: Jamie Clayton
redirect_from:
  - /code/ProductionReady.md
  - /code/ProductionReady
  - /code/ProductionReady.html
---
## Learning Objectives

After reading this document, you will understand:

- What "production ready" means across 8 dimensions
- How to evaluate whether your system meets production standards
- Common failure modes for each dimension and how to prevent them

What does 'Production Ready' really mean for a software engineer? This document defines the critical requirements that separate experimental code from software safe to deploy to customers.

A system is **production ready** when it can reliably serve customers 24/7 with minimal manual intervention, recover gracefully from failures, and provide visibility into its health and performance.

## Core Tenants

### 1. Stability and Reliability

Your software must handle the reality of production: network timeouts, database slowdowns, third-party service failures, and user behavior you didn't anticipate.

**What this means:**

- Code paths have been tested under load and failure conditions
- Error handling is explicit; failures don't cascade silently
- No single point of failure brings down the entire system
- Critical operations have retry logic with exponential backoff
- Configuration changes don't require code redeployment

**Real-world example:** A payment processing service that fails gracefully when the payment gateway is slow, queuing requests instead of timing out.

### 2. Scalability and Performance

Your system must support growth—more users, more data, more transactions—without requiring architectural redesign.

**What this means:**

- Response times meet published SLAs at expected load
- Database queries are indexed and optimized (no N+1 queries)
- Stateless services can scale horizontally by adding instances
- Resource usage is predictable and doesn't leak memory/connections
- Load testing validates performance under 2-3x expected peak load

**Real-world example:** A web API that handles 100 requests/second on a single instance can handle 1000 requests/second by adding 10 instances without code changes.

### 3. Fault Tolerance & Disaster Recovery

Failures will happen. Production-ready systems expect and survive them.

**What this means:**

- Critical data is backed up and can be restored in a known timeframe
- Services degrade gracefully (return cached data, simplified response)
- Deployments don't cause downtime (zero-downtime deployments, blue-green, canary)
- Database migrations are reversible
- You have a documented runbook for common failures

**Real-world example:** A notification service experiences database corruption; it switches to a read-only mode, delivering cached notifications until repairs complete.

### 4. Monitoring and Observability

You cannot fix what you cannot see. Production systems must be instrumented to reveal their internal state.

**What this means:**

- Application metrics are collected: request latency, error rates, business metrics
- Logs are structured (JSON) and searchable, not unstructured text dumps
- Distributed tracing connects requests across multiple services
- Alerts fire for degradation, not just outages (p99 latency up 50%, error rate > 1%)
- On-call engineers can diagnose issues in < 15 minutes with available logs

**Real-world example:** A spike in p99 latency is detected automatically, and logs show a specific database query was added that wasn't optimized.

### 5. Security and Compliance

Your software handles customer data. Breaches damage reputation and invite legal liability.

**What this means:**

- Secrets (API keys, passwords) are never committed or logged
- Authentication and authorization are enforced consistently
- Input validation prevents injection attacks
- Data in transit is encrypted (TLS/HTTPS)
- Compliance requirements (GDPR, PCI-DSS, SOC 2) are met and auditable

**Real-world example:** A form input is validated to prevent SQL injection; logs never contain passwords or API keys.

### 6. Documentation

Production-ready systems are documented so future maintainers (including future you) understand how they work.

**What this means:**

- README explains how to run the service locally
- API documentation is up-to-date and includes error codes
- Architecture decisions are recorded (why did we use this pattern?)
- Deployment instructions are clear and tested
- Runbooks exist for common operational tasks

## Production Ready Checklist

Use this checklist before deploying to production:

### Reliability

- [ ] All error paths are logged with context (user ID, request ID, etc.)
- [ ] Critical operations have retry logic with exponential backoff
- [ ] Timeouts are set on all external service calls (no infinite waits)
- [ ] Database connections are pooled and limits are enforced
- [ ] Memory and CPU usage is monitored; no obvious leaks under load

### Performance

- [ ] Response times meet SLA at expected peak load (2-3x expected)
- [ ] Slow queries (>100ms) are identified and indexed
- [ ] Pagination is implemented for large result sets
- [ ] Caching strategies are in place for frequently accessed data
- [ ] Database migrations tested on production-sized dataset

### Deployment

- [ ] Deployments can be rolled back in < 5 minutes
- [ ] Zero-downtime deployment strategy is tested (blue-green, canary, rolling)
- [ ] Database schema changes are backward compatible
- [ ] Feature flags allow dark deployment of unfinished features
- [ ] Deployment process is automated and tested (no manual steps)

### Monitoring

- [ ] Key metrics are collected: latency, error rate, throughput
- [ ] Business metrics are tracked (signups, conversions, revenue)
- [ ] Alerts are configured for degradation (p99 latency spike, error rate > 1%)
- [ ] Runbook exists for each alert explaining how to respond
- [ ] Log aggregation is set up; logs are searchable and retained

### Security

- [ ] Secrets are stored in a secrets manager, never in code or logs
- [ ] All user input is validated and sanitized
- [ ] Authentication is enforced; authorization is checked on every resource
- [ ] Data at rest and in transit is encrypted
- [ ] Dependencies are scanned for known vulnerabilities

### Documentation

- [ ] README includes setup, local development, and deployment instructions
- [ ] API documentation is current with example requests/responses
- [ ] Architecture decisions are documented in decision records
- [ ] Deployment runbook covers normal and emergency procedures
- [ ] Common troubleshooting scenarios have documented solutions

## Implementation Strategy

### Step 1: Create Guidelines (Week 1)

Define what "production ready" means for your organization. Adapt this checklist to your context (startup vs. enterprise, web app vs. background job).

### Step 2: Automate Checks (Week 2-3)

Implement CI/CD gates that block deployment if requirements aren't met:

- Lint checks (code style)
- Test coverage thresholds (e.g., >80%)
- Performance benchmarks (requests/second, latency)
- Security scans (SAST, dependency vulnerabilities)

### Step 3: Measure and Iterate (Week 4+)

Track production incidents and root-cause them. Did the incident appear in logs? Could monitoring have caught it? Update guidelines based on real-world failures.

## Common Pitfalls

**Pitfall:** "We'll monitor it in production and fix issues as they come up."  
**Reality:** By then, customers have experienced downtime. Build for production from the start.

**Pitfall:** "We don't need retries; the network is reliable enough."  
**Reality:** Network failures are inevitable. Retries save your service from cascading failures.

**Pitfall:** "We'll add monitoring later."  
**Reality:** When production breaks at 2am, instrumentation must already exist. Instrument as you build.

## References

- [Production-Ready Microservices by Susan J. Fowler](https://www.oreilly.com/library/view/production-ready-microservices/9781491965962/)
- [Release It! by Michael Nygard](https://pragprog.com/titles/mnee2/release-it-second-edition/)
- [The DevOps Handbook](https://itrevolution.com/the-devops-handbook/)

## See Also

- [CQRS](/posts/2020/09/18/cqrs/) — read/write separation for scalable systems
- [Microservices](/posts/2021/04/21/microservices-architecture/) — health checks and resilience patterns
- [Code Coverage](/posts/2020/11/20/code-coverage/) — measuring test quality

