---
title: Docker CLI Reference
date: 2026-05-16 09:00:00 +1000
categories: [Reference, DevOps]
tags: [containers, cli]
author: Jamie Clayton
redirect_from:
  - /devops/Containers-Reference.md
  - /devops/Containers-Reference
  - /devops/Containers-Reference.html
---
Quick-lookup for Docker CLI commands used in Windows development environments.

## Image Management

| Command                     | Description                | Example                                       |
| --------------------------- | -------------------------- | --------------------------------------------- |
| `docker pull <image>:<tag>` | Download a versioned image | `docker pull redis/redis-stack:7.2.0-v11`     |
| `docker image ls`           | List local images          | `docker image ls redis/redis-stack`           |
| `docker image rm <image>`   | Remove a local image       | `docker image rm redis/redis-stack:7.2.0-v11` |
| `docker image prune`        | Remove all unused images   | `docker image prune`                          |

## Container Lifecycle

| Command                 | Description                             | Example                             |
| ----------------------- | --------------------------------------- | ----------------------------------- |
| `docker run`            | Create and start a container            | See flags below                     |
| `docker ps`             | List running containers                 | `docker ps --filter name=dev-redis` |
| `docker ps -a`          | List all containers (including stopped) | `docker ps -a`                      |
| `docker stop <name>`    | Gracefully stop a container             | `docker stop dev-redis`             |
| `docker rm <name>`      | Remove a stopped container              | `docker rm dev-redis`               |
| `docker restart <name>` | Restart a container                     | `docker restart dev-redis`          |

## Common `docker run` Flags

| Flag                                  | Purpose                       | Example                       |
| ------------------------------------- | ----------------------------- | ----------------------------- |
| `--detach` / `-d`                     | Run in background             | `docker run -d redis`         |
| `--name <name>`                       | Assign a name                 | `--name dev-redis`            |
| `--hostname <host>`                   | Set container hostname        | `--hostname cache`            |
| `--publish <host>:<container>` / `-p` | Forward a port                | `--publish 6379:6379`         |
| `--env <KEY=VALUE>` / `-e`            | Set environment variable      | `--env REDIS_PASSWORD=secret` |
| `--volume <host>:<container>` / `-v`  | Mount a volume                | `--volume C:/data:/data`      |
| `--rm`                                | Auto-remove container on exit | `docker run --rm alpine sh`   |
| `--interactive --tty` / `-it`         | Attach interactive terminal   | `docker run -it ubuntu bash`  |

## Inspection and Debugging

| Command                        | Description                      | Example                               |
| ------------------------------ | -------------------------------- | ------------------------------------- |
| `docker logs <name>`           | View container logs              | `docker logs dev-redis`               |
| `docker logs -f <name>`        | Follow logs in real time         | `docker logs -f dev-redis`            |
| `docker exec -it <name> <cmd>` | Run command in running container | `docker exec -it dev-redis redis-cli` |
| `docker inspect <name>`        | Full container metadata (JSON)   | `docker inspect dev-redis`            |
| `docker stats`                 | Live CPU/memory usage            | `docker stats`                        |

## Security Scanning

| Command                          | Description              | Example                                              |
| -------------------------------- | ------------------------ | ---------------------------------------------------- |
| `docker scout quickview <image>` | CVE summary for an image | `docker scout quickview redis/redis-stack:7.2.0-v11` |
| `docker scout cves <image>`      | Detailed CVE list        | `docker scout cves redis/redis-stack:7.2.0-v11`      |

## Networking

| Command                                    | Description                   | Example                                    |
| ------------------------------------------ | ----------------------------- | ------------------------------------------ |
| `docker network ls`                        | List networks                 | `docker network ls`                        |
| `docker network create <name>`             | Create a user-defined network | `docker network create app-net`            |
| `docker network connect <net> <container>` | Add container to network      | `docker network connect app-net dev-redis` |

## External Documentation

- [Docker CLI reference](https://docs.docker.com/reference/cli/docker/)
- [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
- [Docker Hub](https://hub.docker.com/)

