---
title: "Module 4 — Hello, Kernel: SK + Bedrock from C#"
date: 2026-06-09 11:00:00 +1000
categories: [Tutorial, AI]
tags: [artificial-intelligence, dotnet]
author: Jamie Clayton
---

> **[Prompt & Tool Design for .NET Teams](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)** · Part 2 — Semantic Kernel in .NET · Module 4 of 12

Finally, some C#. The good news for a .NET team: the kernel is a dependency-injection container with a different job title. You register services, you resolve them, you call them. You have done this a thousand times. The only new idea is that one of those services happens to be a large language model.

## Objective

Stand up Semantic Kernel against Bedrock from a console app, and see the kernel for what it is — a dependency injection (DI) container for AI services.

## Read (~10 min)

- [Semantic Kernel overview](https://learn.microsoft.com/en-us/semantic-kernel/overview/).
- [Understanding the kernel](https://learn.microsoft.com/en-us/semantic-kernel/concepts/kernel) — it really is a DI container, so this will feel familiar.
- The [SK + Bedrock announcement](https://devblogs.microsoft.com/semantic-kernel/introducing-aws-bedrock-with-semantic-kernel/), with a C# snippet halfway down.

## Lab (~20 min)

Create the console app and add the packages:

```bash
dotnet new console -n Sk.Lab04 --framework net10.0
dotnet add package Microsoft.SemanticKernel
dotnet add package Microsoft.SemanticKernel.Connectors.Amazon --prerelease
```

Then wire up the kernel and say hello:

```csharp
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.ChatCompletion;

// The Bedrock connector ships behind an experimental flag. SKEXP0070 is the
// compiler politely warning you the API may still move; pin the package
// version in your repo and carry on.
#pragma warning disable SKEXP0070
var kernel = Kernel.CreateBuilder()
    .AddBedrockChatCompletionService("anthropic.claude-3-5-haiku-20241022-v1:0")
    .Build();
#pragma warning restore SKEXP0070

var chat = kernel.GetRequiredService<IChatCompletionService>();

var history = new ChatHistory("You are a concise, helpful assistant.");
history.AddUserMessage("Explain idempotency keys in two sentences.");

Console.WriteLine(await chat.GetChatMessageContentAsync(history));
```

Credentials come from your normal Amazon Web Services (AWS) profile. Wire them through `AWSSDK.Extensions.NETCore.Setup` the same way you would for any other AWS SDK call. Commit the app as `module-04/`.

> ⚠️ The Amazon connector is still prerelease/alpha — vendor-speak for "it works, until a Tuesday." Pin the version in the repo and note it in your Architecture Decision Record (ADR). [Module 7](/Docs/posts/2026/06/09/prompt-tool-design-07-separation-of-concerns/) is where we decide which layer that abstraction boundary belongs in.

## Done when

You get a model response, and you can put your finger on the single line you'd change to swap providers, without touching any of the calling code.

---

## Series navigation

- ↑ [Course index](/Docs/posts/2026/06/09/prompt-tool-design-dotnet/)
- ← Previous: [Module 3 — Tool design: the API contract for models](/Docs/posts/2026/06/09/prompt-tool-design-03-tool-design/)
- → Next: [Module 5 — Plugins: exposing .NET code to the model](/Docs/posts/2026/06/09/prompt-tool-design-05-plugins/)
