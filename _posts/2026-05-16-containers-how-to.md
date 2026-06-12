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
Task-oriented recipes for common container jobs on Windows with Docker Desktop. Each one is self-contained — jump to the task you need. They assume Docker Desktop is installed and running, and the commands are written for PowerShell.

## How to Run RabbitMQ in Docker

Goal: get a RabbitMQ broker running locally with its management UI, so your app has something to talk to.

```powershell
docker run `
    --detach `
    --hostname rabbit `
    --name dev-rabbit `
    --publish 5672:5672 `
    --publish 15672:15672 `
    rabbitmq:3-management
```

That publishes two ports: `5672` for the AMQP protocol your app connects on, and `15672` for the management UI. Open `http://localhost:15672` in a browser and sign in with the default credentials, `guest` / `guest`.

> Those default credentials only work over `localhost`. RabbitMQ blocks the `guest` account on remote connections by design, so don't expect them to work once you expose the broker beyond your machine.
{: .prompt-warning }

## How to Pass Secrets to a Container

Goal: hand a password to a container during local development without committing it anywhere.

Don't bake secrets into image environment variables — they end up in the image history for anyone to read. For local work, prompt for the value and pass it through `--env`:

```powershell
$dbPassword = Read-Host -AsSecureString "DB password"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($dbPassword)
)
docker run --env DB_PASSWORD=$plain myapp
```

Heads up: this is fine for your own machine, but it isn't a production pattern. The value still lands in the container's environment and shows up in `docker inspect`. For production, use Docker secrets or whatever secret store your orchestrator provides.

## How to Use Docker Behind a Corporate Proxy

Goal: let Docker pull images when your network forces traffic through a proxy.

Point Docker Desktop at your proxy first:

1. Open Docker Desktop > Settings > Resources > Proxies.
2. Set **Web Server (HTTP)** and **Secure Web Server (HTTPS)** to your proxy URL (for example, `http://proxy.corp.example.com:8080`).
3. Add `localhost,127.0.0.1` to the **Bypass list**.
4. Click **Apply & Restart**.

That covers image pulls. If a CLI tool *inside* a container also needs the proxy — say it fetches packages at runtime — pass the proxy settings through as environment variables too:

```powershell
docker run `
    --env HTTP_PROXY=http://proxy.corp.example.com:8080 `
    --env HTTPS_PROXY=http://proxy.corp.example.com:8080 `
    --env NO_PROXY=localhost,127.0.0.1 `
    myapp
```

## See Also

- [Containers Tutorial](/Docs/posts/2026/05/16/containers-redis-tutorial/) — start here if you are new to Docker
- [Containers Reference](/Docs/posts/2026/05/16/docker-cli-reference/) — full Docker CLI cheat sheet
- [Containers Explanation](/Docs/posts/2026/05/16/understanding-containers/) — why containers matter and what they don't solve


