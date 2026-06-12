---
title: Prompt & Tool Design for .NET Teams
date: 2026-06-09 20:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, dotnet, ai, llm, semantic-kernel, bedrock, agentcore, terraform, prompt-engineering]
author: Jamie Clayton
---

## A self-paced course: Semantic Kernel · Amazon Bedrock · AgentCore · Terraform

Twelve modules that take a .NET team still saying "we keep hearing about agents" and get it actually shipping one — without anyone learning Python or pretending they enjoy Jupyter notebooks.

New to the jargon? An **agent** is just a program that lets a language model decide which of your own functions to call, and when. Demystifying that one sentence is the whole course. So if you're a manager or a curious non-coder, you can read the openers and "Objective" of each module and follow the story without touching the labs. There's a [plain-English glossary](#plain-english-glossary) at the foot of this page for everything else.

**Audience:** Experienced .NET engineers with no prior AI/LLM, Python, or Model Context Protocol (MCP) experience. If you've spent a decade shipping line-of-business C# and have been nodding along in meetings about "agentic workflows," this is for you.

**Format:** 12 modules, each 30 minutes or less: read or watch, then write code. Run it as 2–3 modules a week over a month, or block out two days and power through. The modules build on each other, so resist the urge to start at Module 8 because Terraform feels like home.

**Stack:** C# / .NET 10, Semantic Kernel, Amazon Bedrock (Converse API), Bedrock AgentCore, Terraform.

> This page is the **course index**. Each module is its own article. Work through them in order, or jump to a topic if you already know what you're missing. The [course outline](#course-outline) links every one.

---

## The big picture

Before the modules zoom in one piece at a time, here's the whole thing on a single page. If the boxes look unfamiliar now, that's fine. By the capstone you'll have built every one of them.

![Component diagram, ".NET Agentic Solution on AWS". A .NET application (a Semantic Kernel host) invokes an agent on Bedrock AgentCore, which reasons over Amazon Bedrock foundation models through the Converse API and calls a .NET Lambda tool via an action group. IAM grants access, SSM Parameter Store supplies prompts and config, and OpenTelemetry collects telemetry. Solid lines are the runtime call path; dashed lines are config, permissions, and telemetry.](/assets/dotnet-agent-on-aws-bedrock.svg)
_The whole system on one page. Solid arrows are the runtime call path — your .NET app drives an agent that reasons over Bedrock models and calls a .NET Lambda tool. Dashed arrows are the supporting cast: IAM permissions, prompts and config in SSM Parameter Store, and OpenTelemetry traces. Each module builds one of these boxes; the capstone wires them together._

---

## Before you start

One-time setup, about 20 minutes, and no, it doesn't count as a module.

- An Amazon Web Services (AWS) account or sandbox with Bedrock model access enabled. Request access to at least one Anthropic Claude model and one Amazon Nova model (console → Bedrock → Model access). Approval is usually instant, occasionally not, so do this first rather than discovering it mid-lab.
- The .NET 10 SDK, your usual IDE, and the AWS CLI configured with a profile.
- Terraform 1.7 or newer.
- A git repo called `ai-enablement-labs`. Every module commits its lab output here. By the end it's your team's shared reference codebase, rather than twelve abandoned folders in someone's Downloads.

**Cost note:** Every lab uses on-demand inference with small models and short prompts. You'll spend cents, not dollars. Set a budget alarm anyway — it's good hygiene, and future-you debugging a runaway loop at 2am will appreciate the early warning.

---

## Course outline

### Part 1 — Prompt & Tool Design Fundamentals

> No .NET yet. Three modules to build the mental model everything else rests on. If you only absorb one module in the whole course, make it Module 3.

- **Module 1** — [How to talk to a model](/Docs/posts/2026/06/09/prompt-tool-design-01-talk-to-a-model/) — why structure beats wording; role, structure, examples.
- **Module 2** — [Structured prompts, system prompts & templates](/Docs/posts/2026/06/09/prompt-tool-design-02-structured-prompts/) — prompts as versioned artifacts, not string literals you're quietly ashamed of.
- **Module 3** — [Tool design: the API contract for models](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/) — what separates a tool the model uses correctly from one it quietly ignores. **The highest-leverage module.**

### Part 2 — Semantic Kernel in .NET

- **Module 4** — [Hello, Kernel: SK + Bedrock from C#](/Docs/posts/2026/06/09/prompt-tool-design-04-hello-kernel/) — the kernel is a dependency injection (DI) container. You already know DI containers.
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
- Keep everything in the shared `ai-enablement-labs` repo. The Architecture Decision Records (ADRs) from Modules 7 and 9, and the checklist from Module 12, are the artifacts worth keeping after the course — not throwaway lab files.
- **Freshness warning:** AgentCore, the Semantic Kernel (SK) Amazon connector, and Terraform's provider coverage all move monthly, sometimes weekly. The links throughout were verified June 2026. Before you start Part 4, have one person spend fifteen minutes confirming current general availability (GA) and region status (Sydney availability matters) and connector versions. This paragraph is, fittingly, the part most likely to be out of date by the time you read it.

---

## Plain-English glossary

For anyone reading along without writing the code. The modules don't assume you've memorised these — they're here for when a term trips you up.

- **Model** (or **large language model**, **LLM**) — the AI that reads text and writes text back. It predicts likely words; it doesn't "know" things the way a person does.
- **Prompt** — the instructions and information you hand the model. Clearer, better-structured prompts get better answers.
- **System prompt** — the standing instructions that set the model's role and rules, kept separate from each individual question.
- **Agent** — a program that lets the model decide which of your functions to call, and when, to get a task done.
- **Tool** (also called **function calling**) — one of those functions, described to the model so it can choose to use it — for example, "find a comic about merge conflicts."
- **Plugin** — in Semantic Kernel, the .NET class that holds your tools.
- **Guardrail** — a safety filter that checks what goes into and comes out of the model, such as blocking personal data.
- **Semantic Kernel (SK)** — Microsoft's .NET toolkit for wiring models and tools together from C#.
- **Amazon Bedrock** — the AWS service that hosts the models you call. **AgentCore** is its newer set of building blocks for running and connecting agents.
- **Terraform** — a tool for describing cloud infrastructure in text files, so it can be reviewed and rebuilt reliably instead of clicked together by hand.
- **Model Context Protocol (MCP)** — a shared standard for exposing tools to agents. This course gets you productive without writing one.

## Reference shelf

Not required reading, but worth a bookmark.

- [Semantic Kernel in-depth samples](https://learn.microsoft.com/en-us/semantic-kernel/get-started/detailed-samples) — every feature as runnable tests.
- [SK BedrockAgent agent type](https://learn.microsoft.com/en-us/semantic-kernel/frameworks/agent/agent-types/bedrock-agent) — drive Bedrock managed agents through SK's agent abstraction.
- [AWS Skill Builder: Foundations of Prompt Engineering](https://skillbuilder.aws) — free eLearning; search the catalogue for the title.
- [Official C# MCP SDK](https://github.com/modelcontextprotocol/csharp-sdk) — for when you _do_ want to write MCP servers in-stack.
- [Terraform + AgentCore deployment patterns](https://www.pierreange.ai/blog/deploy-your-own-deep-research-agent) — with observability.
