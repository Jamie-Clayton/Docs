---
title: "Module 2 — Structured prompts, system prompts & templates"
date: 2026-06-09 09:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, prompt-engineering, llm]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 1 — Fundamentals · Module 2 of 12

A prompt buried in a string literal is technical debt that talks back. It works in the demo, nobody can find it in code review, and six weeks later someone "tidies up" the whitespace and quietly changes the model's behaviour. This module treats prompts the way you already treat the rest of your code.

## Objective

Treat prompts as engineering artifacts: structured, versioned, and kept well clear of your application logic.

## Read (~10 min)

- Anthropic's interactive tutorial, Chapters 4–6 — separating data from instructions, output formatting, and step-by-step reasoning ("precognition"). Same repo as [Module 1](/Docs/posts/2026/06/09/prompt-tool-design-01-talk-to-a-model/).
- Bookmark the [AWS prompt-engineering workshop](https://catalog.workshops.aws/prompt-eng-claude3/en-US); you'll dip back into it later.

## Lab (~15 min)

Take the prompt you built in [Module 1](/Docs/posts/2026/06/09/prompt-tool-design-01-talk-to-a-model/) and turn it into a **template**:

- a **system prompt** holding the role, the rules, and the output schema;
- a **user prompt** with `{{placeholders}}` for the bits that change;
- the **input data** fenced off clearly — XML tags or code blocks — so the model never mistakes your data for your instructions.

Test it with two genuinely different inputs. Commit as `module-02/summary.prompt.md`.

## Done when

Swapping the input data needs zero edits to the instructions. If you find yourself tweaking the rules to cope with a new ticket, your data and your instructions aren't actually separated yet — go back and move the line.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 1 — How to talk to a model](/Docs/posts/2026/06/09/prompt-tool-design-01-talk-to-a-model/)
- → Next: [Module 3 — Tool design: the API contract for models](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/)
