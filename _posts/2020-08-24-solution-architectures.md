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
Software architecture is the set of high-level decisions that shape how a system is built, deployed, and evolved. This post is for engineers and technical leads who have to choose a pattern, defend that choice to stakeholders, and live with the consequences. It walks through the patterns I reach for most, how I size a system's importance before spending money on it, and how to write the decision down so the next person understands it.

## Why the decision matters

Every architectural choice is a trade-off. Picking a monolith over microservices buys you simpler operations and costs you independent scaling and team autonomy; picking microservices reverses that bargain. There is no free option. The job is to make the trade visible so the people funding the work can agree to it with their eyes open.

## Sizing the system: the outage questions

Stakeholders routinely undervalue a system until it stops. When that happens in a workshop, three questions make the risk concrete:

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

Run these with the executive team before any architectural investment. The answers tell you how much resilience the system actually warrants, which keeps you from gold-plating a back-office tool or under-building something the business can't trade without.

## Common patterns

| Pattern | Description | When to Use |
|---------|-------------|-------------|
| Monolith | Single deployable unit, shared database | Small teams, early-stage product |
| Microservices | Independent services, independent databases | Large teams, different scaling needs |
| CQRS | Separate read/write models | Complex domains, high read/write asymmetry |
| Event Sourcing | Store events, not state | Audit requirements, time-travel queries |
| Serverless | Cloud-managed functions | Infrequent, bursty workloads |

## Write the decision down (ADRs)

Patterns age, teams turn over, and the reasoning behind a choice evaporates fast. An Architecture Decision Record captures *why* a choice was made, not just what was chosen, so the engineer who inherits it in two years doesn't relitigate a settled question. Keep them short. One decision per record.

```markdown
# ADR-001: [Decision Title]

**Status:** Accepted / Deprecated / Superseded

**Context:** What situation forced this decision?

**Decision:** What was decided?

**Consequences:** What are the trade-offs?
```

## The takeaway

Architecture is a series of trade-offs you make on purpose and record so others can see your reasoning. Size the system before you invest in it, pick the pattern whose costs you can afford, and write down why. If you do nothing else from this post, do that last part — undocumented decisions are the ones that get reversed by accident.

## Further Reading

- [Continuous Architecture](/Docs/posts/2023/10/08/continuous-architecture/) — architecture as an ongoing practice
- [Microservices](/Docs/posts/2021/04/21/microservices-architecture/) — decomposing a monolith
- [CQRS](/Docs/posts/2020/09/18/cqrs/) — read/write separation
- [Cloud Computing Diagrams](https://docs.rightscale.com/cm/designers_guide/cm-cloud-computing-system-architecture-diagrams.html)
- [Contingency Planning](https://www.mindtools.com/media/Diagrams/Contingency_Planning_Example1.pdf)


