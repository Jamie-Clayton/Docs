---
title: "Module 7 — Separation of concerns: where AI touches your architecture"
date: 2026-06-09 14:00:00 +1000
categories: [Tutorial, AI]
tags: [artificial-intelligence, dotnet, design-patterns]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 2 — Semantic Kernel in .NET · Module 7 of 12

This is the module that decides whether you enjoy this codebase in a year. Left unchecked, AI code spreads: a model ID hard-coded in a controller here, a prompt concatenated into a service there, and suddenly "swap the model" is a three-day refactor. The fix is boring and effective: put the boundaries in on purpose, now, while the codebase is still small enough to argue about.

## Objective

Define the architectural boundaries so AI code stays in its lane instead of seeping through the whole solution.

## Read (~12 min)

- [Microsoft.Extensions.AI](https://learn.microsoft.com/en-us/dotnet/ai/microsoft-extensions-ai) — the `IChatClient` abstraction Semantic Kernel (SK) itself is converging on.
- [Semantic Kernel filters](https://learn.microsoft.com/en-us/semantic-kernel/concepts/enterprise-readiness/filters), for cross-cutting concerns like logging, personally identifiable information (PII) redaction, and approval gates.

## The layering to adopt

Discuss this as a team. The disagreements are the useful part.

- **Domain** — owns business logic and the inner services your plugins wrap. Never holds prompts, model IDs, or SK types.
- **AI orchestration** — owns kernel setup, plugins (thin adapters over domain services), prompt templates as embedded resources, and filters. Never holds business rules.
- **Infrastructure** — owns model IDs, region, credentials, and guardrail Amazon Resource Names (ARNs); it is all configuration, and hard-codes nothing.

## Lab (~18 min)

Refactor Modules [4](/Docs/posts/2026/06/09/prompt-tool-design-04-hello-kernel/)–[6](/Docs/posts/2026/06/09/prompt-tool-design-06-function-calling/):

- prompts move out of string literals into `/Prompts/*.md` embedded resources;
- the model ID moves into `appsettings`;
- add one `IFunctionInvocationFilter` that logs every tool call with its arguments and duration.

```csharp
using System.Diagnostics;
using Microsoft.Extensions.Logging;
using Microsoft.SemanticKernel;

public sealed class LoggingFilter(ILogger<LoggingFilter> logger)
    : IFunctionInvocationFilter
{
    public async Task OnFunctionInvocationAsync(
        FunctionInvocationContext context,
        Func<FunctionInvocationContext, Task> next)
    {
        var sw = Stopwatch.StartNew();
        logger.LogInformation("Invoking {Plugin}.{Function}",
            context.Function.PluginName, context.Function.Name);

        await next(context); // the function actually runs here

        logger.LogInformation("Invoked {Plugin}.{Function} in {Elapsed}ms",
            context.Function.PluginName, context.Function.Name, sw.ElapsedMilliseconds);
    }
}
```

Register it through dependency injection (DI) on the kernel builder:

```csharp
kernelBuilder.Services.AddSingleton<IFunctionInvocationFilter, LoggingFilter>();
```

Then write a one-page Architecture Decision Record (ADR) — "How AI components integrate with our solution" — and commit it as `module-07/adr-001-ai-boundaries.md`. Future hires will read this instead of asking you.

## Done when

Changing model or provider is a config change, and deleting the AI orchestration project doesn't break the domain layer's compile. If the domain project won't build without the AI project, the boundary is on paper only.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 6 — Function calling: letting the model drive your tools](/Docs/posts/2026/06/09/prompt-tool-design-06-function-calling/)
- → Next: [Module 8 — Bedrock resources in Terraform](/Docs/posts/2026/06/09/prompt-tool-design-08-bedrock-terraform/)
