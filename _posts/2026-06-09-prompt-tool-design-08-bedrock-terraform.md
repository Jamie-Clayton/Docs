---
title: "Module 8 — Bedrock resources in Terraform"
date: 2026-06-09 15:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, terraform, bedrock, iac]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 3 — Infrastructure as Code · Module 8 of 12

A Bedrock agent you created by clicking around the console is an agent nobody can reproduce and everybody is slightly afraid of. This module declares the same thing in Terraform, where it can be reviewed, diffed, and destroyed on purpose. If you've written Terraform for anything else, none of this is new — it's just new resource names.

## Objective

Define a Bedrock managed agent, an action group, and a guardrail declaratively.

## Read (~10 min)

- The Terraform AWS provider's `aws_bedrockagent_agent` resource: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/bedrockagent_agent>
- A walkthrough with full HCL — agent, alias, and IAM, kept model-agnostic via variables: <https://dev.to/suhas_mallesh/deploy-your-first-bedrock-agent-with-terraform-model-agnostic-and-future-proof-25k>

## Lab (~20 min)

Start with the agent and its execution role. This is the verified shape from the current provider — note `foundation_model` reads from a variable, which is the whole point of the closing exercise:

```hcl
variable "model_id" {
  type    = string
  default = "anthropic.claude-3-5-haiku-20241022-v1:0"
}

data "aws_iam_policy_document" "agent_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["bedrock.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "agent" {
  name_prefix        = "AmazonBedrockExecutionRoleForAgents_"
  assume_role_policy = data.aws_iam_policy_document.agent_trust.json
}

resource "aws_bedrockagent_agent" "leave_assistant" {
  agent_name                  = "leave-assistant"
  agent_resource_role_arn     = aws_iam_role.agent.arn
  foundation_model            = var.model_id
  idle_session_ttl_in_seconds = 500
  # The same system prompt you wrote in Module 2.
  instruction                 = "You are a concise assistant for HR platform engineers."
}
```

Then add, following the walkthrough above:

- an **action group** pointing at a stub Lambda — a C# Lambda that reuses your [`LeavePlugin`](/Docs/posts/2026/06/09/prompt-tool-design-05-plugins/) logic;
- an **`aws_bedrock_guardrail`** with a basic PII filter;
- the IAM permissions the agent needs to invoke the model.

Test it in the console's agent test pane, then `terraform destroy` when you're done. (Do the `destroy`. An idle agent costs nothing, but tidy is a habit.)

## Done when

`terraform apply` gives you a working agent, and the foundation model is a `var.model_id` — so a model upgrade is a one-line change to your tfvars, not a hunt through the codebase.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 7 — Separation of concerns: where AI touches your architecture](/Docs/posts/2026/06/09/prompt-tool-design-07-separation-of-concerns/)
- → Next: [Module 9 — Module structure, environments & prompt-as-config](/Docs/posts/2026/06/09/prompt-tool-design-09-module-structure/)
