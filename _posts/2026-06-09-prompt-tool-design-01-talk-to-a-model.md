---
title: "Module 1 — How to talk to a model"
date: 2026-06-09 08:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, ai, llm, prompt-engineering]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 1 — Fundamentals · Module 1 of 12

The model doesn't read your mind. It reads your prompt, literally, and fills every gap you leave with the most statistically likely thing — which is rarely the thing you meant. Most "the AI got it wrong" moments are really "the prompt was ambiguous and the model picked the wrong reading." This module is about removing the ambiguity.

## Objective

Understand why prompt _structure_ matters more than prompt _wording_, and learn the three techniques you'll reach for constantly: role, structure, and examples.

## Read and do (~30 min)

Interleaved — read a chapter, then immediately try it.

- Anthropic's [Interactive Prompt Engineering Tutorial](https://github.com/anthropics/prompt-eng-interactive-tutorial), Chapters 1–3 only. It's built around notebooks, but you don't need Python for any of this. Do every exercise in the Bedrock **Chat playground** (or Anthropic's web console) instead: read the chapter, type the prompt by hand, watch what changes.
- Skim the [prompt-engineering technique index](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/overview) so you know what exists for later.

## Lab

In the Bedrock Chat playground, take a simple prompt — "summarise this text in three bullet points", for instance — and improve it three times:

1. Add a role ("You are a precise technical editor...").
2. Add output-format constraints (a fixed structure, a length limit).
3. Add one worked example of a good summary.

Save all four versions and their outputs to the repo as `module-01/prompt-iterations.md`. Keep the bad first draft. It's the control group.

## Done when

You can explain to a colleague why version 4 beats version 1 — not "it reads better," but precisely _which ambiguity each change removed_. If you can't name the ambiguity you closed, the model couldn't see it either.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/) — and read **Before you start** first if you skipped it
- → Next: [Module 2 — Structured prompts, system prompts & templates](/Docs/posts/2026/06/09/prompt-tool-design-02-structured-prompts/)
