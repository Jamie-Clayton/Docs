---
title: "Module 3 — Tool design: the API contract for models"
date: 2026-06-09 10:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, tool-use, prompt-engineering, ai]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 1 — Fundamentals · Module 3 of 12

This is the one. If the course had a single takeaway, it would be this module. A tool definition is just an API — except the consumer is a model that read your description exactly once, took it completely literally, and will never raise a clarifying ticket.

## Objective

Learn what makes a tool definition good. The model sees only your name, your description, and your JSON schema. It cannot read the implementation, it cannot ask what you meant, and it will not give you the benefit of the doubt.

## Read (~12 min)

- Anthropic's tool-use guide, especially the concepts and best-practices section: <https://docs.claude.com/en/docs/agents-and-tools/tool-use/overview>
- AWS Converse API tool use: <https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html>

## Key principles

1. **Tool descriptions are prompts.** Write them like docs for a sharp but painfully literal junior dev who will never ask a follow-up question.
2. **Fewer, well-scoped tools beat many overlapping ones.** Two tools that do almost the same thing are two tools the model can pick wrongly.
3. **Return errors as text the model can recover from**, not stack traces. `Employee not found; IDs look like EMP-NNNNN` is worth more to the model than a 500 and a wall of red.
4. **Schema constraints are cheaper than prose.** An `enum` or a `required` field _enforces_ what a paragraph of careful instructions only _suggests_.

## Lab (~18 min)

No code yet. Pick a real service from your own solution — `LeaveBalanceService`, say — and write tool definitions (name, description, JSON input schema, example output) for two or three of its operations, as if you were handing them to a model. Then peer-review in pairs with one question in mind: _could a literal-minded stranger misuse this?_ Commit as `module-03/tool-contracts.md`.

This is the peer review worth slowing down for. It's also where someone discovers your "obvious" parameter name meant something different to everyone in the room.

## Done when

Your reviewer can predict exactly when the model would call each tool, and with what arguments, from the definition alone. If they have to ask "what does this one do?", so would the model — and the model would guess rather than ask.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 2 — Structured prompts, system prompts & templates](/Docs/posts/2026/06/09/prompt-tool-design-02-structured-prompts/)
- → Next: [Module 4 — Hello, Kernel: SK + Bedrock from C#](/Docs/posts/2026/06/09/prompt-tool-design-04-hello-kernel/)
