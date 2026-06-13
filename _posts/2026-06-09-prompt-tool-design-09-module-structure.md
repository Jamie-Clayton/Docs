---
title: "Module 9 — Module structure, environments & prompt-as-config"
date: 2026-06-09 16:00:00 +1000
categories: [Tutorial, AI]
tags: [artificial-intelligence, infrastructure-as-code]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 3 — Infrastructure as Code · Module 9 of 12

[Module 8](/Docs/posts/2026/06/09/prompt-tool-design-08-bedrock-terraform/) got an agent stood up. This module makes it production-shaped: one reusable module, instances per environment, and a deliberate answer to the question everyone eventually asks: _where do the prompts actually live?_

## Objective

Turn the Module 8 stack into a reusable module with per-environment instances, and decide, on purpose, how prompts are managed.

## Read (~8 min)

- Skim [this AgentCore monorepo walkthrough](https://dev.to/aws-builders/terraform-your-aws-agentcore-11kl) for structure, not detail — a full agent platform deployed with a single `terraform apply`.

## Lab (~17 min)

Refactor Module 8 into `modules/bedrock-agent/` with a `variables.tf` covering the model ID, the instruction file path, and guardrail config. Instantiate it for `dev` and `test`.

Crucially, load the agent instruction from a file rather than a string literal:

```hcl
resource "aws_bedrockagent_agent" "this" {
  agent_name              = "comic-assistant-${var.environment}"
  agent_resource_role_arn = aws_iam_role.agent.arn
  foundation_model        = var.model_id
  instruction             = file("${path.module}/prompts/agent-instruction.md")
}
```

Now a prompt change is a diff in `agent-instruction.md`, reviewable in a pull request (PR) like any other change, not an edit someone made in a console text box at 4pm and forgot to tell anyone about.

**Team discussion (10 min, fine to do async in the PR):** should prompt changes ride the same pipeline as your infrastructure changes, or get a faster lane — say, Bedrock Prompt Management? There's no universal right answer; there's a right answer for your team's risk appetite. Record it as an Architecture Decision Record (ADR). Call it ADR-002.

## Done when

Two environments come from one module, and a prompt edit shows up as a clean `terraform plan` diff — the kind a reviewer can actually reason about.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 8 — Bedrock resources in Terraform](/Docs/posts/2026/06/09/prompt-tool-design-08-bedrock-terraform/)
- → Next: [Module 10 — AgentCore concepts](/Docs/posts/2026/06/09/prompt-tool-design-10-agentcore-concepts/)
