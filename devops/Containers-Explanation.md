# Understanding Containers for Local Development

> **Document Type:** Explanation
> **Related how-to:** [Containers How-to](Containers-HowTo.md) | **Related reference:** [Docker CLI Reference](Containers-Reference.md)

## Overview

Containers package an application and its dependencies into a single, portable unit that runs consistently across different machines. For local development on Windows, containers solve the "it works on my machine" problem by giving every developer an identical runtime environment.

## Why This Matters

Local development environments drift. One developer has Redis 6, another has Redis 7. One has a specific SSL certificate installed, another doesn't. When the production environment differs from local, bugs hide until deployment.

Containers eliminate that drift. A container image pins the exact version of every dependency, including the operating system libraries. If your team all runs the same image, they all run the same environment.

## How Containers Work

A **container image** is a read-only, layered snapshot of a filesystem. When you run `docker pull redis:7`, you're downloading those layers to your machine.

A **container** is a running instance of an image. It adds a thin writable layer on top of the image layers. Multiple containers can run from the same image simultaneously, each with its own writable layer — changes in one container don't affect others.

The **Docker Engine** (running inside Docker Desktop on Windows) manages the Linux kernel namespaces and cgroups that isolate containers from each other and from the host.

On Windows, Docker Desktop runs a lightweight Linux VM (using WSL 2) that hosts the Docker Engine. Your containers run inside that VM, but Docker Desktop exposes the CLI and port mappings to Windows as if they were native.

## Trade-offs and Considerations

**Containers are good for:**
- Running third-party services (databases, message brokers, caches) without installing them natively
- Creating reproducible environments for CI/CD pipelines
- Isolating services from each other to prevent dependency conflicts

**Containers are not a solution for:**
- Persistent data storage without explicit volume mounts (the writable layer is discarded when the container is removed)
- Replacing a full development environment — your IDE, compiler, and SDK still run natively
- Hiding security vulnerabilities — the image's base OS and packages must still be kept updated

## When to Use Containers for Local Development

**Good fit:**
- You need Redis, RabbitMQ, PostgreSQL, or any other external service for development
- Your team has different operating systems (macOS, Windows, Linux) and needs a consistent service layer
- You want to test your app against a specific version of a dependency without changing your system installation

**Not a good fit:**
- The service's startup time or resource usage outweighs the benefit (consider mocks or in-process fakes instead)
- You need deep OS-level integration that containers abstract away

## Further Reading

- [Containers Tutorial](Containers-Tutorial.md) — hands-on: run Redis in Docker
- [Containers How-to](Containers-HowTo.md) — recipes for RabbitMQ, secrets, and proxies
- [Containers Reference](Containers-Reference.md) — Docker CLI cheat sheet
- [Microservices with Containers](Containers-ServiceFabric.md) — container orchestration concepts
- [Docker documentation](https://docs.docker.com/)
- [WSL 2 and Docker Desktop](https://docs.docker.com/desktop/wsl/)
