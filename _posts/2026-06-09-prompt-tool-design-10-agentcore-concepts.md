---
title: "Module 10 — AgentCore concepts"
date: 2026-06-09 17:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, agentcore, aws, ai]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 4 — AgentCore and Production · Module 10 of 12

No code this time: read, watch, and reframe. AgentCore is Amazon Web Services' (AWS) name for five things you have almost certainly already built worse versions of: somewhere to run the agent, a way to expose tools, somewhere to keep memory, an identity story, and observability. The value isn't novelty; it's not maintaining your own.

## Objective

Understand the AgentCore primitives — Runtime, Gateway, Memory, Identity, Observability — and where each one replaces something you'd otherwise hand-roll.

## Read and watch (~25 min)

- The [AgentCore product overview](https://aws.amazon.com/bedrock/agentcore/).
- The [AgentCore docs landing page](https://docs.aws.amazon.com/bedrock-agentcore/); skim the service map.
- A video: [search YouTube for "AgentCore deep dive re:Invent"](https://www.youtube.com/results?search_query=amazon+bedrock+agentcore+deep+dive+reinvent) and pick the most recent official AWS session. Keep it to something six months old or newer. This service moves fast enough that older talks describe a different product.

## The reframe that matters for a .NET team

Two things to take away, because they're the bits AWS's Python-heavy examples bury:

- **Runtime hosts containers that speak an HTTP contract.** A .NET service is a first-class citizen here, regardless of what the sample repo's file extensions imply.
- **Gateway turns ordinary APIs and Lambdas into agent-ready tools.** This is why you don't need to learn to write a Model Context Protocol (MCP) server to get started. The Gateway does that translation for you. ([Module 11](/Docs/posts/2026/06/09/prompt-tool-design-11-gateway/) puts this into practice.)

## Done when

You can name, for at least one primitive, a system you've built before that it would replace or remove. "Memory replaces the session store you'd otherwise stand up and maintain yourself" is the level of concrete you're after.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 9 — Module structure, environments & prompt-as-config](/Docs/posts/2026/06/09/prompt-tool-design-09-module-structure/)
- → Next: [Module 11 — Gateway: a .NET Lambda as an agent tool](/Docs/posts/2026/06/09/prompt-tool-design-11-gateway/)
