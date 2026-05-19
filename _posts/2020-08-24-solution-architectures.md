---
title: Solution Architectures
date: 2020-08-24 09:00:00 +1000
categories: [Explanation, Architecture]
tags: [architecture, solutions]
author: Jamie Clayton
redirect_from:
  - /devops/Architecture.md
  - /devops/Architecture
  - /devops/Architecture.html
---
## Overview

Software architecture is the set of high-level decisions that shape how a system is built, deployed, and evolved. This document covers common architecture patterns, how to evaluate them, and how to communicate architectural risk to stakeholders.

## Why Architecture Decisions Matter

Every architectural choice creates trade-offs. A decision to use a monolith vs. microservices affects team autonomy, deployment complexity, and operational costs. Getting stakeholder buy-in requires making these trade-offs visible.

## Assessing System Impact: The Outage Questions

When stakeholders undervalue a system's importance, these three questions make the risk concrete:

1. **What if your system was offline for 1 hour?**
   - Immediate customer impact?
   - Revenue loss?
   - Manual workarounds available?

2. **What if your system was offline for 1 day?**
   - Regulatory or compliance implications?
   - Data loss risk?
   - Customer trust impact?

3. **What if your system was offline for more than 1 week?**
   - Business continuity risk?
   - Competitor advantage?
   - Recovery cost vs. prevention cost?

Use these questions in workshops with executive teams to size the importance of a system before any architectural investment.

## Common Architecture Patterns

| Pattern | Description | When to Use |
|---------|-------------|-------------|
| Monolith | Single deployable unit, shared database | Small teams, early-stage product |
| Microservices | Independent services, independent databases | Large teams, different scaling needs |
| CQRS | Separate read/write models | Complex domains, high read/write asymmetry |
| Event Sourcing | Store events, not state | Audit requirements, time-travel queries |
| Serverless | Cloud-managed functions | Infrequent, bursty workloads |

## Architecture Decision Records (ADRs)

Document significant architectural decisions so future engineers understand *why* a choice was made.

Format:

```markdown
# ADR-001: [Decision Title]

**Status:** Accepted / Deprecated / Superseded

**Context:** What situation forced this decision?

**Decision:** What was decided?

**Consequences:** What are the trade-offs?
```

## Learning Objectives

After reading this document, you will understand:
- How to quantify the impact of a system outage
- Common architecture patterns and when to apply them
- How to document architectural decisions with ADRs

## Further Reading

- [Continuous Architecture](/Docs/posts/2023/10/08/continuous-architecture/) — architecture as an ongoing practice
- [Microservices](/Docs/posts/2021/04/21/microservices-architecture/) — decomposing a monolith
- [CQRS](/Docs/posts/2020/09/18/cqrs/) — read/write separation
- [Cloud Computing Diagrams](https://docs.rightscale.com/cm/designers_guide/cm-cloud-computing-system-architecture-diagrams.html)
- [Contingency Planning](https://www.mindtools.com/media/Diagrams/Contingency_Planning_Example1.pdf)


