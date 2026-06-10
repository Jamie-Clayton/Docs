---
title: Prompt & Tool Design for .NET Teams
date: 2026-06-09 20:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, dotnet, ai, llm, semantic-kernel, bedrock, agentcore, terraform, prompt-engineering]
author: Jamie Clayton
---

## A self-paced course: Semantic Kernel · Amazon Bedrock · AgentCore · Terraform

Twelve modules that take a .NET team from "we keep hearing about agents" to actually shipping one — without anyone learning Python or pretending they enjoy Jupyter notebooks.

**Audience:** Experienced .NET engineers with no prior AI/LLM, Python, or MCP experience. If you've spent a decade shipping line-of-business C# and have been nodding along in meetings about "agentic workflows," this is for you.

**Format:** 12 modules, each 30 minutes or less — read or watch, then write code. Run it as 2–3 modules a week over a month, or block out two days and power through. The modules build on each other, so resist the urge to start at Module 8 because Terraform feels like home.

**Stack:** C# / .NET 10, Semantic Kernel, Amazon Bedrock (Converse API), Bedrock AgentCore, Terraform.

> This page is the **course index**. Each module is its own article. Work through them in order, or jump to a topic if you already know what you're missing. The [course outline](#course-outline) links every one.

---

## Before you start

One-time setup, about 20 minutes, and no, it doesn't count as a module.

- An AWS account or sandbox with Bedrock model access enabled. Request access to at least one Anthropic Claude model and one Amazon Nova model (console → Bedrock → Model access). Approval is usually instant, occasionally not, so do this first rather than discovering it mid-lab.
- The .NET 10 SDK, your usual IDE, and the AWS CLI configured with a profile.
- Terraform 1.7 or newer.
- A git repo called `ai-enablement-labs`. Every module commits its lab output here. By the end it's your team's shared reference codebase, rather than twelve abandoned folders in someone's Downloads.

**Cost note:** Every lab uses on-demand inference with small models and short prompts. You'll spend cents, not dollars. Set a budget alarm anyway — it's good hygiene, and future-you debugging a runaway loop at 2am will appreciate the early warning.

---

## Course outline

### Part 1 — Prompt & Tool Design Fundamentals

> No .NET yet. Three modules to build the mental model everything else rests on. If you only truly absorb one module in the whole course, make it Module 3.

- **Module 1** — [How to talk to a model](/Docs/posts/2026/06/09/prompt-tool-design-01-talk-to-a-model/) — why structure beats wording; role, structure, examples.
- **Module 2** — [Structured prompts, system prompts & templates](/Docs/posts/2026/06/09/prompt-tool-design-02-structured-prompts/) — prompts as versioned artifacts, not string literals you're quietly ashamed of.
- **Module 3** — [Tool design: the API contract for models](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/) — what separates a tool the model uses correctly from one it quietly ignores. **The highest-leverage module.**

### Part 2 — Semantic Kernel in .NET

- **Module 4** — [Hello, Kernel: SK + Bedrock from C#](/Docs/posts/2026/06/09/prompt-tool-design-04-hello-kernel/) — the kernel is a DI container. You already know DI containers.
- **Module 5** — [Plugins: exposing .NET code to the model](/Docs/posts/2026/06/09/prompt-tool-design-05-plugins/) — turn the Module 3 contracts into real, callable C#.
- **Module 6** — [Function calling: letting the model drive your tools](/Docs/posts/2026/06/09/prompt-tool-design-06-function-calling/) — the request → tool call → result → answer loop, and what to do when it loops badly.
- **Module 7** — [Separation of concerns: where AI touches your architecture](/Docs/posts/2026/06/09/prompt-tool-design-07-separation-of-concerns/) — boundaries, so AI code doesn't quietly seep into every layer.

### Part 3 — Infrastructure as Code with Terraform

- **Module 8** — [Bedrock resources in Terraform](/Docs/posts/2026/06/09/prompt-tool-design-08-bedrock-terraform/) — agent, action group, and guardrail, declared rather than clicked.
- **Module 9** — [Module structure, environments & prompt-as-config](/Docs/posts/2026/06/09/prompt-tool-design-09-module-structure/) — make Module 8 production-shaped.

### Part 4 — AgentCore and Production

- **Module 10** — [AgentCore concepts](/Docs/posts/2026/06/09/prompt-tool-design-10-agentcore-concepts/) — Runtime, Gateway, Memory, Identity, Observability, and which piece of hand-rolled plumbing each one replaces.
- **Module 11** — [Gateway: a .NET Lambda as an agent tool](/Docs/posts/2026/06/09/prompt-tool-design-11-gateway/) — expose your Module 8 Lambda as a tool. No Python, no MCP server.
- **Module 12** — [Capstone: end to end](/Docs/posts/2026/06/09/prompt-tool-design-12-capstone/) — wire it all together and write down what "done" actually means for an AI feature.

---

## Suggested cadence & facilitation

- **Weeks 1–4:** Modules 1–3, then 4–6, then 7–9, then 10–12. Hold one 30-minute team huddle a week to compare lab output. The peer reviews in M3 and M5 are where the real arguments — and the real learning — happen.
- Keep everything in the shared `ai-enablement-labs` repo. The ADRs (M7, M9) and the checklist (M12) are the artifacts worth keeping after the course — not throwaway lab files.
- **Freshness warning:** AgentCore, the SK Amazon connector, and Terraform's provider coverage all move monthly, sometimes weekly. The links throughout were verified June 2026. Before you start Part 4, have one person spend fifteen minutes confirming current GA and region status (Sydney availability matters) and connector versions. This paragraph is, fittingly, the part most likely to be out of date by the time you read it.

## Reference shelf

Not required reading, but worth a bookmark.

- [Semantic Kernel in-depth samples](https://learn.microsoft.com/en-us/semantic-kernel/get-started/detailed-samples) — every feature as runnable tests.
- [SK BedrockAgent agent type](https://learn.microsoft.com/en-us/semantic-kernel/frameworks/agent/agent-types/bedrock-agent) — drive Bedrock managed agents through SK's agent abstraction.
- [AWS Skill Builder: Foundations of Prompt Engineering](https://skillbuilder.aws) — free eLearning; search the catalogue for the title.
- [Official C# MCP SDK](https://github.com/modelcontextprotocol/csharp-sdk) — for when you _do_ want to write MCP servers in-stack.
- [Terraform + AgentCore deployment patterns](https://www.pierreange.ai/blog/deploy-your-own-deep-research-agent) — with observability.
