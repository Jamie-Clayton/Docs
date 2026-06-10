---
title: "Module 11 — Gateway: a .NET Lambda as an agent tool"
date: 2026-06-09 18:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, agentcore, dotnet, aws]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 4 — AgentCore and Production · Module 11 of 12

[Module 5](/Docs/posts/2026/06/09/prompt-tool-design-05-plugins/) exposed a function to the model from inside your own process. Gateway does the same job across the network: it takes a Lambda you already have and presents it to an agent as a tool, deriving the schema for you. No Python, no Model Context Protocol (MCP) server, no new protocol to learn.

## Objective

Expose the C# Lambda from [Module 8](/Docs/posts/2026/06/09/prompt-tool-design-08-bedrock-terraform/) as a tool via AgentCore Gateway.

## Read (~10 min)

- The [AgentCore Gateway "Getting started" guide](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/gateway.html).
- A [reference architecture with Terraform](https://caylent.com/blog/building-a-secure-rag-application-with-amazon-bedrock-agentcore-and-terraform), including Gateway and tools — skim the gateway sections.
- The [official AgentCore samples repository](https://github.com/awslabs/amazon-bedrock-agentcore-samples), for a gateway example to crib from.

## Lab (~20 min)

Register the C# Lambda from Module 8 as a Gateway target. Good news since this course was first written: the Amazon Web Services (AWS) provider now ships `aws_bedrockagentcore_gateway` and `aws_bedrockagentcore_gateway_target`, so you can declare the whole thing instead of clicking through the console:

```hcl
resource "aws_bedrockagentcore_gateway" "example" {
  name     = "comic-gateway"
  role_arn = aws_iam_role.gateway_role.arn

  authorizer_configuration {
    custom_jwt_authorizer {
      discovery_url = "https://your-idp/.well-known/openid-configuration"
    }
  }
}

resource "aws_bedrockagentcore_gateway_target" "comic" {
  name               = "find-comic"
  gateway_identifier = aws_bedrockagentcore_gateway.example.gateway_id
  description        = "Exposes the comic-finder Lambda as an agent tool"

  credential_provider_configuration {
    gateway_iam_role {}
  }

  target_configuration {
    mcp {
      lambda {
        lambda_arn = aws_lambda_function.comic.arn

        tool_schema {
          inline_payload {
            name        = "find_comic"
            description = "Finds a programming or tech comic for a given topic."

            input_schema {
              type = "object"

              property {
                name        = "topic"
                type        = "string"
                description = "Topic or keyword, e.g. git or deadlines"
                required    = true
              }
            }
          }
        }
      }
    }
  }
}
```

The `name` and `description` in that tool schema are the same contract you wrote in [Module 3](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/) and implemented in [Module 5](/Docs/posts/2026/06/09/prompt-tool-design-05-plugins/). Invoke the tool through the Gateway's endpoint and confirm the schema it presents matches what you intended. If it doesn't, the Gateway is right and your annotations are wrong — fix the Lambda.

The authorizer above expects a JSON Web Token (JWT) from your identity provider; point `discovery_url` at your own.

## Done when

An agent (or a test harness) calls your .NET code through the Gateway, and you've noted anything that still isn't expressible in Terraform for your Architecture Decision Record (ADR). Provider coverage has caught up a lot, but it's worth confirming against your pinned version.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 10 — AgentCore concepts](/Docs/posts/2026/06/09/prompt-tool-design-10-agentcore-concepts/)
- → Next: [Module 12 — Capstone: end to end](/Docs/posts/2026/06/09/prompt-tool-design-12-capstone/)
