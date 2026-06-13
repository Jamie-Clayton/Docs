---
title: Understanding Containers for Local Development
date: 2026-05-16 09:00:00 +1000
categories: [Explanation, DevOps]
tags: [devops]
author: Jamie Clayton
redirect_from:
  - /devops/Containers-Explanation.md
  - /devops/Containers-Explanation
  - /devops/Containers-Explanation.html
---
This page explains what containers are and why they help with local development on Windows. It's for developers who keep hearing "just run it in a container" and want to understand what that actually means before they start typing commands.

## What a container is

A container packages an application together with everything it needs to run — its libraries, its configuration, the right version of its dependencies — into a single unit that behaves the same way on any machine. That's the whole idea, and it's why containers are the standard answer to "but it works on my machine."

## The problem containers solve

Local development environments drift apart over time. One developer has Redis 6, another has Redis 7. One has a particular SSL certificate installed, another doesn't. As long as everyone's machine is a little different, bugs can hide in those differences and only show up once the code reaches production.

Containers stop that drift. A container image pins the exact version of every dependency, right down to the operating system libraries. If everyone on your team runs the same image, everyone runs the same environment. Here's why that matters: the gap between "works locally" and "works in production" gets smaller, because both are running the same thing.

## How containers actually work

There are three pieces worth knowing, and you'll meet all of them the first time you run a container.

A **container image** is a read-only, layered snapshot of a filesystem. When you run `docker pull redis:7`, you're downloading those layers to your machine. Think of the image as a recipe — it describes what should be there, but it isn't running yet.

A **container** is a running instance of an image. It adds a thin writable layer on top of the image's read-only layers, so the program can write files while it runs. You can start several containers from the same image at once, and each one gets its own writable layer, so changes in one container don't leak into another.

The **Docker Engine** is the piece that does the work. It manages the Linux kernel features (namespaces and cgroups) that keep containers isolated from each other and from the host machine.

On Windows there's one extra wrinkle. Docker Desktop runs a small Linux virtual machine using WSL 2, and the Docker Engine lives inside that VM. Your containers run in there too — but Docker Desktop wires up the command line and the port mappings so that, from Windows, it all feels native. You don't need to manage the VM yourself; it happens behind the scenes.

## What containers are good at, and what they aren't

Containers earn their keep when you're:

- Running third-party services (databases, message brokers, caches) without installing them on your machine.
- Building reproducible environments for CI/CD pipelines.
- Keeping services apart so their dependencies don't conflict.

They won't do these things, and it's worth being clear about the limits up front:

- They don't store data permanently on their own. The writable layer is thrown away when the container is removed, so anything you want to keep needs an explicit volume mount.
- They don't replace your whole development setup. Your IDE, compiler, and SDK still run natively on Windows.
- They don't make security vulnerabilities go away. The image's base OS and packages still need keeping up to date.

I'll be honest about the trade-off here: a container adds a layer of indirection. When something breaks, you're now debugging across the host, the WSL 2 VM, and the container, instead of just one machine. For a reproducible Redis or PostgreSQL that's a price well worth paying. For a service that starts slowly or eats memory, it might not be — a mock or an in-process fake can be the better call.

## When to reach for a container locally

It's a good fit when:

- You need Redis, RabbitMQ, PostgreSQL, or any other external service for development.
- Your team is split across macOS, Windows, and Linux and needs a consistent service layer.
- You want to test against a specific version of a dependency without changing what's installed on your system.

It's a poor fit when:

- The service's startup time or memory use outweighs the benefit. Reach for a mock or an in-process fake instead.
- You need deep OS-level integration that containers are designed to abstract away.

By now you should be able to picture what happens when you run a container, and decide whether one belongs in your local workflow. The tutorial linked below is where you actually run one.

## Further Reading

- [Containers Tutorial](/Docs/posts/2026/05/16/containers-redis-tutorial/) — hands-on: run Redis in Docker
- [Containers How-to](/Docs/posts/2026/05/16/containers-how-to/) — recipes for RabbitMQ, secrets, and proxies
- [Containers Reference](/Docs/posts/2026/05/16/docker-cli-reference/) — Docker CLI cheat sheet
- [Microservices with Containers](/Docs/posts/2020/07/05/containers-service-fabric/) — container orchestration concepts
- [Docker documentation](https://docs.docker.com/)
- [WSL 2 and Docker Desktop](https://docs.docker.com/desktop/wsl/)


