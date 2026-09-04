# DevForge — Internal Developer Platform

## Overview

DevForge is a self-service Internal Developer Platform designed to automate application infrastructure, deployment, and monitoring.

The goal is to provide developers with a consistent and automated path from source code to a running, monitored application environment.

## Technology Stack

* Linux
* Shell Scripting
* Networking
* Git & GitHub
* Docker
* AWS
* Terraform
* CI/CD
* Prometheus
* Grafana

## Project Architecture

```text
Developer
    ↓
GitHub
    ↓
CI/CD
    ↓
Docker
    ↓
AWS Infrastructure
    ↓
Application
    ↓
Prometheus
    ↓
Grafana
```

## Current Phase

### Phase 1 — Linux & Shell

Completed/implemented:

* DevForge directory structure
* System information script
* Server health-check script
* Cleanup automation
* Server setup automation
* Configuration management
* Log directory
* Linux permissions and shell scripting

### Phase 2 — Networking & Git

Completed/implemented:

* Linux network inspection
* IP address and routing inspection
* Connectivity testing
* DNS troubleshooting
* HTTP connectivity testing
* Port and socket inspection
* Nginx installation and configuration
* Git repository initialization
* Git configuration
* `.gitignore`
* GitHub repository integration

### Phase 3 — Docker

Completed/implemented:

* Docker Engine installation
* Docker client and daemon verification
* Docker images and containers
* Container lifecycle management
* Docker Hub image management
* Image inspection
* Image layers and tags
* Container logs
* Executing commands inside containers
* Custom DevForge Docker image
* Dockerfile
* `.dockerignore`
* Docker image build automation
* Container port mapping
* Containerized DevForge web application
* EC2 application access
* Container restart policy
* Docker volume for Nginx logs
* Custom Docker network
* Container-to-container communication
* Docker resource monitoring
* Docker resource cleanup

## Directory Structure

```text
devforge/
├── config/
│   └── devforge.conf
├── logs/
├── scripts/
│   ├── system_info.sh
│   ├── health_check.sh
│   ├── cleanup.sh
│   └── server_setup.sh
├── temp/
├── docker/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── app/
│   │   └── index.html
│   └── scripts/
│       ├── docker-build.sh
│       └── docker-run.sh
└── README.md
```

## Linux & Shell Scripts

### system_info.sh

Collects and displays:

* Operating system
* Hostname
* CPU information
* Memory usage
* Disk usage
* System uptime
* Running processes

### health_check.sh

Checks:

* Disk usage threshold
* Memory usage threshold
* CPU usage threshold
* SSH service status

Returns:

* `0` when all checks pass
* Non-zero when a health check fails

### cleanup.sh

Handles:

* Old log cleanup
* Temporary-file cleanup
* Log retention
* Cleanup status and exit codes

### server_setup.sh

Prepares the Linux environment by:

* Verifying required commands
* Creating DevForge directories
* Setting permissions
* Creating configuration
* Verifying the environment

## Docker

DevForge uses Docker to package and run its web application in an isolated and reproducible environment.

### Docker Architecture

```text
                         AWS EC2
                            │
                      Docker Engine
                            │
                 ┌──────────┴──────────┐
                 │                     │
          devforge-web           devforge-app
             Nginx                 Application
                 │                     │
                 └──── Docker Network ─┘
                       devforge-network

                       │
                       ▼
                 devforge-logs
                    Volume

EC2 Port 8080 ───────► Container Port 80
```

### Docker Image

The DevForge application is packaged using a custom Docker image based on `nginx:alpine`.

The Dockerfile:

* Uses `nginx:alpine` as the base image
* Copies the DevForge application webpage into the Nginx web root
* Exposes port 80
* Adds image metadata using Docker labels

### Build the Image

```bash
./docker/scripts/docker-build.sh
```

Or manually:

```bash
docker build -t devforge-web:v1 ./docker
```

### Run the Application

```bash
./docker/scripts/docker-run.sh
```

The container runs with:

* Container name: `devforge-web`
* Container port: `80`
* Host port: `8080`
* Restart policy: `unless-stopped`
* Docker network: `devforge-network`
* Log volume: `devforge-logs`

### Verify the Application

```bash
curl http://localhost:8080
```

The application can also be accessed through:

```text
http://<EC2-PUBLIC-IP>:8080
```

### Docker Volume

DevForge uses a Docker volume to persist Nginx logs:

```text
devforge-logs
```

The volume is mounted at:

```text
/var/log/nginx
```

This allows logs to persist even when the container is removed.

### Docker Network

DevForge uses a custom Docker network:

```text
devforge-network
```

Containers connected to this network can communicate using Docker's internal DNS and container names.

Example:

```bash
curl http://devforge-web
```

### Container Operations

Common operations:

```bash
docker ps
docker ps -a
docker logs devforge-web
docker inspect devforge-web
docker restart devforge-web
docker stop devforge-web
docker start devforge-web
docker rm devforge-web
```

### Resource Monitoring

```bash
docker stats --no-stream
```

### Docker Cleanup

Unused stopped containers can be safely removed with:

```bash
docker container prune
```

## Configuration

Configuration values are stored in:

```text
config/devforge.conf
```

Current thresholds:

* Disk: 80%
* Memory: 80%
* CPU: 80%
* Log retention: 7 days

## Future Phases

1. ~~Linux & Shell~~
2. ~~Networking & Git~~
3. ~~Docker~~
4. AWS
5. Terraform
6. CI/CD
7. Prometheus
8. Grafana
9. Platform integration and testing

## Goal

The final platform should allow developers to push application code and receive an automated, reproducible, containerized, deployed, and monitored environment with minimal manual infrastructure work.

