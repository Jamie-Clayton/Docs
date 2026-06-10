---
title: "Module 5 — Plugins: exposing .NET code to the model"
date: 2026-06-09 12:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, dotnet, semantic-kernel, tool-use]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 2 — Semantic Kernel in .NET · Module 5 of 12

In Semantic Kernel (SK), a "plugin" is a class with a couple of attributes on it. That's the entire trick. The tool contract you argued over in [Module 3](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/) becomes an ordinary C# method, and the description you wrote becomes the thing the model actually reads.

## Objective

Turn the tool contract from Module 3 into a real, callable C# function the model can invoke.

## Read (~8 min)

- The [Semantic Kernel plugins concept](https://learn.microsoft.com/en-us/semantic-kernel/concepts/plugins/).
- The MS Learn module [Create plugins for Semantic Kernel](https://learn.microsoft.com/training/paths/develop-ai-agents-azure-open-ai-semantic-kernel-sdk) (learning path APL-2005) — skim the C# units.

## Lab (~22 min)

Implement your Module 3 contract as a plugin. Our running example is a comic finder — it returns a programming comic from sites like [xkcd](https://xkcd.com), [CommitStrip](https://www.commitstrip.com), [MonkeyUser](https://www.monkeyuser.com), [Geek & Poke](https://geek-and-poke.com), or [Work Chronicles](https://workchronicles.com/):

```csharp
using System.ComponentModel;
using Microsoft.SemanticKernel;

public class ComicPlugin
{
    [KernelFunction("find_comic")]
    [Description("Finds a programming or tech comic for a given topic. "
        + "Use when the user wants a comic, a laugh, or a cartoon about a software concept.")]
    public Task<string> FindComicAsync(
        [Description("Topic or keyword, e.g. \"git\" or \"deadlines\"")] string topic)
        => Task.FromResult(
            $$"""
            {"topic":"{{topic}}","title":"Git","url":"https://xkcd.com/1597/","source":"xkcd"}
            """);
}
```

Register it with the kernel:

```csharp
kernel.Plugins.AddFromType<ComicPlugin>();
```

Stub the data — a hard-coded comic link is fine. Wiring up a real comic search is a solved problem and, frankly, a productivity hazard; the contract is the point. (Note the `$$"""..."""` raw interpolated string: doubled braces escape the literal JSON, and the single `{{topic}}` is the value. It saves you a fight with backslashes.)

## Done when

The `[Description]` attributes are word-for-word the descriptions you peer-reviewed in [Module 3](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/), and your reviewer signs off on them a second time. If the wording drifted, the model is now reading something nobody reviewed.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 4 — Hello, Kernel: SK + Bedrock from C#](/Docs/posts/2026/06/09/prompt-tool-design-04-hello-kernel/)
- → Next: [Module 6 — Function calling: letting the model drive your tools](/Docs/posts/2026/06/09/prompt-tool-design-06-function-calling/)
