---
title: Containers How-to Guides
date: 2026-05-16 09:00:00 +1000
categories: ['How-to', DevOps]
tags: [docker, containers]
author: Jamie Clayton
redirect_from:
  - /devops/Containers-HowTo.md
  - /devops/Containers-HowTo
  - /devops/Containers-HowTo.html
---
How-to recipes for common container tasks on Windows with Docker Desktop.

## How to Run RabbitMQ in Docker

```powershell
docker run `
    --detach `
    --hostname rabbit `
    --name dev-rabbit `
    --publish 5672:5672 `
    --publish 15672:15672 `
    rabbitmq:3-management
```

Access the management UI at `http://localhost:15672` (default credentials: `guest` / `guest`).

## How to Pass Secrets to a Container

Never bake secrets into environment variables in production. For local development, use `--env` with values from your shell:

```powershell
$dbPassword = Read-Host -AsSecureString "DB password"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($dbPassword)
)
docker run --env DB_PASSWORD=$plain myapp
```

For production, use Docker secrets or your orchestrator's secret store.

## How to Use Docker Behind a Corporate Proxy

Configure Docker Desktop to route pulls through your proxy:

1. Open Docker Desktop > Settings > Resources > Proxies
2. Set **Web Server (HTTP)** and **Secure Web Server (HTTPS)** to your proxy URL (e.g., `http://proxy.corp.example.com:8080`)
3. Add `localhost,127.0.0.1` to **Bypass list**
4. Click **Apply & Restart**

For CLI tools inside a container that need the proxy:

```powershell
docker run `
    --env HTTP_PROXY=http://proxy.corp.example.com:8080 `
    --env HTTPS_PROXY=http://proxy.corp.example.com:8080 `
    --env NO_PROXY=localhost,127.0.0.1 `
    myapp
```

## See Also

- [Containers Tutorial](/posts/2026/05/16/containers-redis-tutorial/) — start here if you are new to Docker
- [Containers Reference](/posts/2026/05/16/docker-cli-reference/) — full Docker CLI cheat sheet
- [Containers Explanation](/posts/2026/05/16/understanding-containers/) — why containers matter and what they don't solve

