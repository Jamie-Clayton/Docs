---
title: "Module 5 — Plugins: exposing .NET code to the model"
date: 2026-06-09 12:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, dotnet, semantic-kernel, tool-use]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 2 — Semantic Kernel in .NET · Module 5 of 12

In SK, a "plugin" is a class with a couple of attributes on it. That's the entire trick. The tool contracts you argued over in [Module 3](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/) become ordinary C# methods, and the descriptions you wrote become the thing the model actually reads.

## Objective

Turn a tool contract from Module 3 into a real, callable C# function the model can invoke.

## Read (~8 min)

- SK plugins concept: <https://learn.microsoft.com/en-us/semantic-kernel/concepts/plugins/>
- The MS Learn module "Create plugins for Semantic Kernel" from learning path APL-2005 — skim the C# units: <https://learn.microsoft.com/training/paths/develop-ai-agents-azure-open-ai-semantic-kernel-sdk>

## Lab (~22 min)

Implement one Module 3 contract as a plugin:

```csharp
using System.ComponentModel;
using Microsoft.SemanticKernel;

public class LeavePlugin
{
    [KernelFunction("get_leave_balance")]
    [Description("Returns remaining annual leave hours for an employee. "
        + "Use when the user asks about leave, holidays, or time off remaining.")]
    public Task<string> GetLeaveBalanceAsync(
        [Description("Employee ID in format EMP-NNNNN")] string employeeId)
        => Task.FromResult(
            $$"""
            {"employeeId":"{{employeeId}}","remainingHours":76.0}
            """);
}
```

Register it with the kernel:

```csharp
kernel.Plugins.AddFromType<LeavePlugin>();
```

Stub the data — a hard-coded JSON string is fine. The integration is a solved problem; the contract is the point. (Note the `$$"""..."""` raw interpolated string: doubled braces escape the JSON, single `{{employeeId}}` is the value. It saves you a fight with backslashes.)

## Done when

The `[Description]` attributes are word-for-word the descriptions you peer-reviewed in [Module 3](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/), and your reviewer signs off on them a second time. If the wording drifted, the model is now reading something nobody reviewed.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 4 — Hello, Kernel: SK + Bedrock from C#](/Docs/posts/2026/06/09/prompt-tool-design-04-hello-kernel/)
- → Next: [Module 6 — Function calling: letting the model drive your tools](/Docs/posts/2026/06/09/prompt-tool-design-06-function-calling/)
