---
title: Prompt & Tool Design for .NET Teams
date: 2026-06-09 20:00:00 +1000
categories: [Learning, DevOps, AI, LLM]
tags: [dotnet, ai, llm, semantic-kernel, bedrock, agentcore, terraform, prompt-engineering]
author: Jamie Clayton
---

## A self-paced course: Semantic Kernel · Amazon Bedrock · AgentCore · Terraform

**Audience:** Experienced .NET engineers with no prior AI/LLM, Python, or MCP experience.
**Format:** 12 modules, each ≤ 30 minutes (reading/video + hands-on coding). Designed to run as 2–3 modules per week over a month, or as a focused 2-day ramp.
**Stack:** C# / .NET 8+, Semantic Kernel, Amazon Bedrock (Converse API), Bedrock AgentCore, Terraform.

---

## Before you start (one-time setup, ~20 min, not counted as a module)

- AWS account/sandbox with Bedrock model access enabled (request access to at least one Anthropic Claude model and one Amazon Nova model in the console → Bedrock → Model access).
- .NET 8 SDK, your usual IDE, AWS CLI configured with a profile.
- Terraform ≥ 1.7 installed.
- Create a git repo `ai-enablement-labs` — every module's lab output is committed there. This becomes the team's shared reference codebase.

**Cost note:** All labs use on-demand inference with small models and short prompts. Expect cents, not dollars, per person. Set a budget alarm anyway.

---

## Part 1 — Prompt & Tool Design Fundamentals

> No .NET yet. These three modules build the mental model everything else sits on. The single highest-leverage skill in this whole course is Module 3.

### Module 1 — How to talk to a model (30 min)

**Objective:** Understand why prompt structure matters more than prompt wording; learn the core techniques (role, structure, examples).

**Read/Do (interleaved, ~30 min):**

- Anthropic's Interactive Prompt Engineering Tutorial — Chapters 1–3 only: <https://github.com/anthropics/prompt-eng-interactive-tutorial>
  (It's notebook-based, but you can do every exercise in the Bedrock console **Chat playground** or Anthropic's web console instead — no Python required. Read the chapter text, type the prompts by hand.)
- Skim the technique index for later reference: <https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/overview>

**Lab:** In the Bedrock Chat playground, take one real prompt from your domain (e.g. "summarise this incident ticket") and improve it three times: (1) add a role, (2) add output format constraints, (3) add one worked example. Save all four versions and outputs to the repo as `module-01/prompt-iterations.md`.

**Done when:** You can explain to a colleague why version 4 beats version 1, in terms of _what ambiguity each change removed_.

---

### Module 2 — Structured prompts, system prompts, and templates (25 min)

**Objective:** Treat prompts as engineering artifacts: structured, versioned, separated from code.

**Read (~10 min):**

- Anthropic interactive tutorial Chapters 4–6 (separating data from instructions, output formatting, precognition/step-by-step): same repo as Module 1.
- AWS workshop reference (bookmark; you'll dip into it later): <https://catalog.workshops.aws/prompt-eng-claude3/en-US>

**Lab (~15 min):** Convert your Module 1 prompt into a **template**: system prompt (role, rules, output schema) + user prompt with `{{placeholders}}` + clearly delimited input data (XML tags or fenced blocks). Test with two different inputs. Commit as `module-02/incident-summary.prompt.md`.

**Done when:** Swapping the input data requires zero edits to the instructions.

---

## Module 3 — Tool design: the API contract for models (30 min)

**Objective:** Learn what makes a tool definition good. This is just API design with a new consumer — the model — and the model only "sees" your name, description, and JSON schema.

**Read (~12 min):**

- Anthropic's tool use guide (concepts + best practices section): <https://docs.claude.com/en/docs/agents-and-tools/tool-use/overview>
- AWS Converse API tool use: <https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html>

**Key principles to extract:**

1. Tool descriptions are prompts — write them like documentation for a smart but literal junior dev.
2. Fewer, well-scoped tools beat many overlapping ones.
3. Return errors as informative text the model can recover from, not stack traces.
4. Schema constraints (enums, required fields) are cheaper than prose instructions.

**Lab (~18 min):** No code. Pick one service from your actual solution (e.g. `LeaveBalanceService`). Write tool definitions (name, description, JSON input schema, example output) for 2–3 operations, as if exposing them to a model. Peer-review in pairs: could a literal-minded stranger misuse this tool? Commit as `module-03/tool-contracts.md`.

**Done when:** Your reviewer can predict exactly when the model would call each tool and with what arguments, from the definition alone.

---

## Part 2 — Semantic Kernel in .NET

### Module 4 — Hello, Kernel: SK + Bedrock from C# (30 min)

**Objective:** Stand up Semantic Kernel against Bedrock and understand the kernel as a DI container for AI services.

**Read (~10 min):**

- SK overview: <https://learn.microsoft.com/en-us/semantic-kernel/overview/>
- Understanding the kernel (it's a DI container — this will feel familiar): <https://learn.microsoft.com/en-us/semantic-kernel/concepts/kernel>
- SK + Bedrock announcement (C# snippet halfway down): <https://devblogs.microsoft.com/semantic-kernel/introducing-aws-bedrock-with-semantic-kernel/>

**Lab (~20 min):** Console app:

```bash
dotnet new console -n Sk.Lab04
dotnet add package Microsoft.SemanticKernel
dotnet add package Microsoft.SemanticKernel.Connectors.Amazon --prerelease
```

```csharp
var kernel = Kernel.CreateBuilder()
    .AddBedrockChatCompletionService("anthropic.claude-3-5-haiku-20241022-v1:0")
    .Build();

var chat = kernel.GetRequiredService<IChatCompletionService>();
var history = new ChatHistory("You are a concise assistant for HR platform engineers.");
history.AddUserMessage("Explain idempotency keys in two sentences.");
Console.WriteLine(await chat.GetChatMessageContentAsync(history));
```

Wire AWS credentials via your normal profile/`AWSSDK.Extensions.NETCore.Setup`. Commit as `module-04/`.

**Done when:** You get a model response and can explain where you'd swap the model ID to change providers without touching calling code.

> ⚠️ The Amazon connector is still prerelease/alpha — pin the version in the repo and note it in your ADR (Module 7 covers where that abstraction boundary should live).

---

### Module 5 — Plugins: exposing .NET code to the model (30 min)

**Objective:** Turn the tool contracts from Module 3 into real, callable C# functions.

**Read (~8 min):**

- SK plugins concept: <https://learn.microsoft.com/en-us/semantic-kernel/concepts/plugins/>
- MS Learn module "Create plugins for Semantic Kernel" from learning path APL-2005 (skim the C# units): <https://learn.microsoft.com/training/paths/develop-ai-agents-azure-open-ai-semantic-kernel-sdk>

**Lab (~22 min):** Implement one Module 3 contract as a plugin:

```csharp
public class LeavePlugin
{
    [KernelFunction("get_leave_balance")]
    [Description("Returns remaining annual leave hours for an employee. Use when the user asks about leave, holidays, or time off remaining.")]
    public Task<string> GetLeaveBalanceAsync(
        [Description("Employee ID in format EMP-NNNNN")] string employeeId)
        => Task.FromResult("""{"employeeId":"%s","remainingHours":76.0}""");
}
```

Register with `kernel.Plugins.AddFromType<LeavePlugin>()`. Stub the data — the point is the contract, not the integration.

**Done when:** The `[Description]` attributes are word-for-word the descriptions you peer-reviewed in Module 3, and your reviewer signs off again.

---

### Module 6 — Function calling: letting the model drive your tools (30 min)

**Objective:** Enable automatic tool invocation and observe the full request → tool call → tool result → answer loop.

**Read (~8 min):**

- SK function calling: <https://learn.microsoft.com/en-us/semantic-kernel/concepts/ai-services/chat-completion/function-calling/>
- How Bedrock's Converse API carries tool calls (so you know what's on the wire): <https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference.html>

**Lab (~22 min):** Enable auto invocation:

```csharp
var settings = new PromptExecutionSettings
{
    FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
};
```

Ask: "How much leave does EMP-00142 have left, in days assuming 7.6-hour days?" Log every step. Then deliberately break it: ask an ambiguous question, pass a malformed ID, return an error string from the plugin — watch how the model recovers (or doesn't), and improve the description/error messages until it does.

> ⚠️ Tool/function-call support in the Amazon connector has historically lagged the OpenAI connector (it was a known gap through 2025). If auto-invocation misbehaves on your pinned version, fall back to calling Converse tool-use directly via `AWSSDK.BedrockRuntime` for this lab — the loop is identical conceptually. Verify current connector status on the NuGet page: <https://www.nuget.org/packages/Microsoft.SemanticKernel.Connectors.Amazon>

**Done when:** You can narrate the message sequence (assistant toolUse block → your function → toolResult block → final answer) from your own logs.

---

### Module 7 — Separation of concerns: where AI touches your architecture (30 min)

**Objective:** Define the architectural boundaries so AI code doesn't metastasise through the solution. The most important module for the codebase you'll live with.

**Read (~12 min):**

- Microsoft.Extensions.AI (`IChatClient` — the abstraction SK itself is converging on): <https://learn.microsoft.com/en-us/dotnet/ai/microsoft-extensions-ai>
- SK filters (cross-cutting concerns: logging, PII redaction, approval gates): <https://learn.microsoft.com/en-us/semantic-kernel/concepts/enterprise-readiness/filters>

**The layering to adopt (discuss as a team):**

| Layer            | Owns                                                                                                        | Never contains               |
| ---------------- | ----------------------------------------------------------------------------------------------------------- | ---------------------------- |
| Domain           | Business logic, plugin implementations' inner services                                                      | Prompts, model IDs, SK types |
| AI orchestration | Kernel setup, plugins (thin adapters over domain services), prompt templates as embedded resources, filters | Business rules               |
| Infrastructure   | Model IDs, region, credentials, guardrail ARNs — all configuration                                          | Hard-coded anything          |

**Lab (~18 min):** Refactor Modules 4–6: prompts out of string literals into `/Prompts/*.md` embedded resources; model ID into `appsettings`; one `IFunctionInvocationFilter` that logs every tool call with arguments and duration. Write a one-page ADR: "How AI components integrate with our solution." Commit as `module-07/adr-001-ai-boundaries.md`.

**Done when:** Changing model/provider is a config change; deleting the AI orchestration project doesn't break the domain layer's compile.

---

## Part 3 — Infrastructure as Code with Terraform

### Module 8 — Bedrock resources in Terraform (30 min)

**Objective:** Define a Bedrock managed agent, action group, and guardrail declaratively.

**Read (~10 min):**

- Terraform AWS provider — `aws_bedrockagent_agent`: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/bedrockagent_agent>
- Walkthrough with full HCL (agent + alias + IAM, model-agnostic via variables): <https://dev.to/suhas_mallesh/deploy-your-first-bedrock-agent-with-terraform-model-agnostic-and-future-proof-25k>

**Lab (~20 min):** Write and apply: `aws_bedrockagent_agent` (instruction = your Module 2 system prompt), an action group pointing at a stub Lambda (a C# Lambda — reuse `LeavePlugin` logic), `aws_bedrock_guardrail` with a basic PII filter, and the IAM role. Test in the console's agent test pane. `terraform destroy` when done.

**Done when:** `terraform apply` → working agent; the foundation model is a `var.model_id`, so a model upgrade is a one-line tfvars change.

---

### Module 9 — Module structure, environments, and the prompt-as-config question (25 min)

**Objective:** Make Module 8 production-shaped: reusable module, per-environment instances, and a deliberate decision about where prompts live.

**Read (~8 min):**

- Skim for structure, not detail — a monorepo deploying a full agent platform with one `terraform apply`: <https://dev.to/aws-builders/terraform-your-aws-agentcore-11kl>

**Lab (~17 min):** Refactor Module 8 into `modules/bedrock-agent/` with `variables.tf` (model ID, instruction file path, guardrail config) and instantiate for `dev` and `test`. Load the agent instruction via `file("${path.module}/prompts/agent-instruction.md")` so prompt changes are diffable in PRs like any other change.

**Team discussion (10 min, can be async in the PR):** Should prompt changes ride the same pipeline as infra changes, or have a faster lane (e.g. Bedrock Prompt Management)? Record the decision as ADR-002.

**Done when:** Two environments from one module; a prompt edit shows up as a clean `terraform plan` diff.

---

## Part 4 — AgentCore and Production

### Module 10 — AgentCore concepts (25 min, no code)

**Objective:** Understand the AgentCore primitives — Runtime, Gateway, Memory, Identity, Observability — and where each replaces something you'd otherwise build.

**Read/Watch (~25 min):**

- Product overview: <https://aws.amazon.com/bedrock/agentcore/>
- Docs landing page (skim the service map): <https://docs.aws.amazon.com/bedrock-agentcore/>
- Video: search YouTube for **"Amazon Bedrock AgentCore deep dive re:Invent"** and pick the most recent official AWS session (≤ 6 months old — this service moves fast): <https://www.youtube.com/results?search_query=amazon+bedrock+agentcore+deep+dive+reinvent>

**Key reframe for this team:** Runtime hosts _containers speaking an HTTP contract_ — a .NET service is a first-class citizen even though AWS's SDK examples are Python. And Gateway converts your existing APIs and Lambdas into agent-ready tools, which is why **nobody needs to learn to write MCP servers** to get started.

**Done when:** Each person can name, for one primitive, the thing in your current architecture it would replace or remove.

---

### Module 11 — Gateway: your existing APIs as agent tools (30 min)

**Objective:** Expose an existing .NET Lambda/API as a tool via AgentCore Gateway — zero Python, zero MCP code.

**Read (~10 min):**

- AgentCore Gateway docs (start at "Getting started"): <https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/gateway.html>
- Reference architecture with Terraform incl. Gateway + tools (skim the gateway sections): <https://caylent.com/blog/building-a-secure-rag-application-with-amazon-bedrock-agentcore-and-terraform>
- Browse the official samples repo for a gateway example: <https://github.com/awslabs/amazon-bedrock-agentcore-samples>

**Lab (~20 min):** Register your Module 8 C# Lambda as a Gateway target (console is fine for the first pass; note any Terraform provider gaps for ADR purposes — coverage was still partial in early 2026, with teams bridging gaps via `awscc` provider or null resources). Invoke it through the Gateway's tool endpoint and confirm the schema the Gateway derived matches your Module 3 contract — fix the Lambda's schema annotations if not.

**Done when:** An agent (or test harness) calls your .NET code through Gateway, and you've logged which pieces were/weren't expressible in Terraform yet.

---

### Module 12 — Capstone: end to end (30 min + optional stretch)

**Objective:** Tie it all together and define your team's definition of done for AI features.

**Build (~25 min, pairs):** A minimal vertical slice: .NET console/API using SK (Modules 4–7 layering) → calls a Bedrock agent or AgentCore-hosted tool path (Modules 8–11) → all infra from `terraform apply` → one filter logging every model and tool interaction.

**Then write the artifact that outlives the course (~5 min each, merge as a team):** `AI-FEATURE-CHECKLIST.md` — your definition of done for any AI interaction shipped to production. Seed it with:

- [ ] Prompt is versioned, templated, and separated from code (M2, M7)
- [ ] Every tool has a reviewed contract: description, schema, error behaviour (M3)
- [ ] Model/provider is config, behind an abstraction (M4, M7)
- [ ] Guardrails attached; PII path reviewed (M8)
- [ ] All infra in Terraform, environments parameterised (M8–M9)
- [ ] Tool calls and model I/O observable in logs (M7, M11)
- [ ] Evaluation: at least N golden prompts with expected behaviours, run before prompt/model changes ship

**Stretch (optional, 30 min):** Take three "golden prompts" from your domain and script a crude eval harness in C# (loop, invoke, assert on structure/keywords). This is the seed of real regression testing for prompts.

---

## Suggested cadence & facilitation

- **Weeks 1–4:** Modules 1–3 / 4–6 / 7–9 / 10–12. One 30-min team huddle per week to compare lab outputs — the peer reviews in M3 and M5 are the highest-value discussions.
- Keep everything in the shared `ai-enablement-labs` repo; the ADRs (M7, M9) and checklist (M12) graduate into your real solution's docs.
- **Freshness warning:** AgentCore, the SK Amazon connector, and Terraform provider coverage are all moving monthly. Links above were verified June 2026; before running Part 4, have one person spend 15 minutes confirming current GA/region status (Sydney availability matters) and connector versions.

## Reference shelf (not required reading)

- SK in-depth samples (every feature, as runnable tests): <https://learn.microsoft.com/en-us/semantic-kernel/get-started/detailed-samples>
- SK BedrockAgent agent type (drive Bedrock managed agents through SK's agent abstraction): <https://learn.microsoft.com/en-us/semantic-kernel/frameworks/agent/agent-types/bedrock-agent>
- AWS Skill Builder — _Foundations of Prompt Engineering_ (free eLearning; search the catalogue at <https://skillbuilder.aws>)
- Official C# MCP SDK, for when you _do_ want to author MCP servers in-stack: <https://github.com/modelcontextprotocol/csharp-sdk>
- Terraform + AgentCore deployment patterns with observability: <https://www.pierreange.ai/blog/deploy-your-own-deep-research-agent>
