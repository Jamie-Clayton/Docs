---
title: "Module 6 — Function calling: letting the model drive your tools"
date: 2026-06-09 13:00:00 +1000
categories: [Tutorial, AI]
tags: [prompt-tool-design, dotnet, semantic-kernel, tool-use, bedrock]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 2 — Semantic Kernel in .NET · Module 6 of 12

So far the model can talk and you have a plugin it can't reach. This module connects the two: you hand the kernel your tools, the model decides when to call them, and Semantic Kernel (SK) runs the back-and-forth. When it works it feels like magic. When it doesn't, it's almost always a description you wrote in [Module 3](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/) coming back to collect.

## Objective

Enable automatic tool invocation and watch the full request → tool call → tool result → answer loop happen.

## Read (~8 min)

- [SK function calling](https://learn.microsoft.com/en-us/semantic-kernel/concepts/ai-services/chat-completion/function-calling/).
- [How Bedrock's Converse API carries tool calls](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference.html), so you know what's actually on the wire.

## Lab (~22 min)

Switch on automatic function calling and let the model reach your `ComicPlugin`:

```csharp
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.ChatCompletion;

var settings = new PromptExecutionSettings
{
    FunctionChoiceBehavior = FunctionChoiceBehavior.Auto()
};

var history = new ChatHistory();
history.AddUserMessage("Find me a comic about merge conflicts.");

// Passing `kernel` is the whole trick. It's what lets SK discover your
// registered plugins and run the tool-call loop for you. Omit it and
// the model has no tools to call — it just talks.
var answer = await chat.GetChatMessageContentAsync(history, settings, kernel);
Console.WriteLine(answer);
```

Log every step. Then deliberately break it: ask for a comic about something nonsensical, pass an empty topic, return an error string from the plugin. Watch how the model recovers — or doesn't, which is the more instructive outcome — and tighten the descriptions and error messages until it copes on its own.

> ⚠️ Tool/function-call support in the Amazon connector has historically lagged the OpenAI connector — it was a known gap through 2025. If auto-invocation misbehaves on your pinned version, fall back to calling Converse tool-use directly via `AWSSDK.BedrockRuntime` for this lab; the loop is conceptually identical. Check the [current connector status on NuGet](https://www.nuget.org/packages/Microsoft.SemanticKernel.Connectors.Amazon) before you assume it's your bug.

## Done when

You can narrate the message sequence — assistant `toolUse` block → your function → `toolResult` block → final answer — from your own logs, with no hand-waving.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 5 — Plugins: exposing .NET code to the model](/Docs/posts/2026/06/09/prompt-tool-design-05-plugins/)
- → Next: [Module 7 — Separation of concerns: where AI touches your architecture](/Docs/posts/2026/06/09/prompt-tool-design-07-separation-of-concerns/)
