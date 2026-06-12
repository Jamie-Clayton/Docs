---
title: Your First Redis on Docker
date: 2026-05-16 09:00:00 +1000
categories: [Tutorial, DevOps]
tags: [docker, redis, tutorial]
author: Jamie Clayton
redirect_from:
  - /devops/Containers-Tutorial.md
  - /devops/Containers-Tutorial
  - /devops/Containers-Tutorial.html
---
> **Tutorial** — learning-oriented. By the end you will have a Redis server running in Docker, set and read a value from the CLI, and view it in a browser GUI.
{: .prompt-info }

This is a hands-on lesson that walks you, step by step, from nothing to a working Redis container you can poke at from both the command line and a browser. It's written for someone who has never touched Redis or Docker before — if that's you, you're in the right place.

## Prerequisites

You'll need two things in place before you start:

- Docker Desktop installed and running on Windows.
- PowerShell 7 (`pwsh`) available.

No prior Redis or Docker experience is assumed. We'll explain each command as we go.

## What you will build

A single Redis container with the official `redis-stack` image, exposing two ports:

- **6379** — the Redis wire protocol, used by the `redis-cli` and by application clients.
- **8001** — RedisInsight, a browser GUI bundled with `redis-stack`.

You will set a key from the command line and then watch the same key appear in the GUI.

## Step 1 — Authenticate with Docker Hub

Docker Hub allows a generous anonymous pull rate, but signing in removes the risk of rate-limit errors mid-tutorial.

```PowerShell
# Open an interactive sign-in. Use your Docker Hub credentials.
docker login
```

If you don't have a Docker Hub account, skip this step — the pull below will still work.

## Step 2 — Pull the image

Pulling the image first (rather than letting `docker run` pull it on demand) means the next step starts the container instantly.

```PowerShell
# A specific, pinned tag — never use `latest` for tutorials you may revisit.
docker pull redis/redis-stack:7.2.0-v11
```

When the command finishes, confirm the image is present locally:

```PowerShell
docker image ls redis/redis-stack
```

## Step 3 — Run the container

This single command starts the container in the background, names it `dev-redis`, and forwards both ports to your host.

```PowerShell
docker run `
    --detach `
    --hostname cache `
    --name dev-redis `
    --publish 6379:6379 `
    --publish 8001:8001 `
    redis/redis-stack:7.2.0-v11
```

Confirm the container is running:

```PowerShell
docker ps --filter name=dev-redis
```

You should see a single row with status `Up <a few seconds>`.

## Step 4 — Set and read a key from the CLI

Open an interactive terminal inside the running container:

```PowerShell
docker exec -it dev-redis redis-cli
```

You are now at the Redis prompt (`127.0.0.1:6379>`). Try these commands one at a time:

```text
SET greeting "Hello from your first container"
GET greeting
INCR visits
INCR visits
GET visits
KEYS *
QUIT
```

`SET` stores a string. `INCR` atomically increments an integer-valued key (and creates it as `1` on first call). `KEYS *` lists every key. That last one is handy in development, but a word of warning: never run it against a production Redis with millions of keys — it scans the whole keyspace and can stall the server.

## Step 5 — View the same key in the GUI

Open `http://localhost:8001` in your browser. RedisInsight loads. Accept the EULA, then pick **Add Redis Database → Connect to Redis Database**. The defaults are correct:

- Host: `127.0.0.1`
- Port: `6379`
- Name: anything you like (e.g. `dev-redis`)

Once connected, expand the database and you will see `greeting` and `visits` — the same keys you just set from the CLI.

## Step 6 — Inspect the container's security posture

`docker scout` ships with Docker Desktop and surfaces known vulnerabilities in an image. Useful even for a throwaway dev container.

```PowerShell
docker scout quickview redis/redis-stack:7.2.0-v11
```

The output groups CVEs by severity. For local development this is informational — for an image you intend to deploy, treat anything in the **Critical** column as a blocker.

## Step 7 — Clean up

```PowerShell
# Stop the container (state is preserved in the Docker engine until removed).
docker stop dev-redis

# Remove the stopped container.
docker rm dev-redis

# Optional: remove the image to reclaim disk space.
docker image rm redis/redis-stack:7.2.0-v11
```

## What just happened

You used four primitives that recur in every container workflow:

1. **`docker pull`** brings a versioned, immutable image to your machine.
2. **`docker run`** creates a container from the image, with a unique name and a published port mapping.
3. **`docker exec`** opens a shell or runs a command inside an already-running container.
4. **`docker stop` / `docker rm`** end the container's lifecycle without affecting the image.

The image is the recipe; the container is the meal. Once you've got the image, you can run as many containers from it as you like, each with its own name, ports, and data. That's the mental model that carries you into everything else.

## Where to go next

- **How-to page** — task-oriented recipes for RabbitMQ, secrets, and corporate-proxy network setups: [Containers-HowTo.md](/Docs/posts/2026/05/16/containers-how-to/)
- **Reference page** — the full Docker CLI cheat sheet: [Containers-Reference.md](/Docs/posts/2026/05/16/docker-cli-reference/)
- **Explanation page** — why containers matter for local development, and what they don't solve: [Containers-Explanation.md](/Docs/posts/2026/05/16/understanding-containers/)

## References

- [Docker Desktop installation](https://docs.docker.com/desktop/install/windows-install/)
- [Redis Stack image on Docker Hub](https://hub.docker.com/r/redis/redis-stack)
- [Redis CLI command reference](https://redis.io/docs/latest/develop/connect/cli/)
- [RedisInsight documentation](https://redis.io/docs/latest/operate/redisinsight/)
- [Docker Scout quickstart](https://docs.docker.com/scout/)
- [Diátaxis framework — Tutorials](https://diataxis.fr/tutorials/)


