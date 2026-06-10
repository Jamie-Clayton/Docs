---
title: "Module 12 — Capstone: end to end"
date: 2026-06-09 19:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, dotnet, semantic-kernel, agentcore, terraform]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 4 — AgentCore and Production · Module 12 of 12

Eleven modules of pieces; this one assembles them. You'll build a thin slice that touches every layer, then write the one document that outlives the course. Courses end. Checklists, fortunately for your future code reviewers, are forever.

## Objective

Tie everything together, and write down what "done" means for an AI feature.

## Build (~25 min, in pairs)

A minimal vertical slice:

- a .NET console or API using Semantic Kernel, layered the way [Module 7](/Docs/posts/2026/06/09/prompt-tool-design-07-separation-of-concerns/) argued for;
- calling a Bedrock agent or an AgentCore-hosted tool path from Modules [8](/Docs/posts/2026/06/09/prompt-tool-design-08-bedrock-terraform/)–[11](/Docs/posts/2026/06/09/prompt-tool-design-11-gateway/);
- all infrastructure created by `terraform apply`;
- one filter (from Module 7) logging every model and tool interaction.

Keep using the comic finder from the earlier labs, or swap in any small example of your own. The slice matters more than the subject.

## The artifact that outlives the course (~5 min each, merge as a team)

Write `AI-FEATURE-CHECKLIST.md` — your definition of done for any AI interaction you'd ship to production. Seed it with:

- [ ] Prompt is versioned, templated, and separated from code (Modules 2, 7)
- [ ] Every tool has a reviewed contract: description, schema, error behaviour (Module 3)
- [ ] Model and provider are configuration, behind an abstraction (Modules 4, 7)
- [ ] Guardrails attached; the personally identifiable information (PII) path reviewed (Module 8)
- [ ] All infrastructure in Terraform, environments parameterised (Modules 8–9)
- [ ] Tool calls and model input/output observable in logs (Modules 7, 11)
- [ ] Evaluation: at least a handful of golden prompts with expected behaviours, run before any prompt or model change ships

## Stretch (optional, ~30 min)

Take three "golden prompts" and script a crude evaluation harness in C# — a loop that invokes each and asserts on structure or keywords. It's primitive, and it's the seed of real regression testing for prompts. The first time a model update quietly breaks one, you'll be glad it exists.

## Done when

The slice runs end to end from `terraform apply` to a logged tool call, and your team has a checklist it actually agrees with — not one copied from a blog and never read again. That's the course.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 11 — Gateway: a .NET Lambda as an agent tool](/Docs/posts/2026/06/09/prompt-tool-design-11-gateway/)
