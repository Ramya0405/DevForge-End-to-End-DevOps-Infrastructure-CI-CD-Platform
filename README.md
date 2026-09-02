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

Developer → GitHub → CI/CD → Docker → AWS Infrastructure → Application → Prometheus → Grafana

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
└── README.md
```

## Scripts

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

## Configuration

Configuration values are stored in:

`config/devforge.conf`

Current thresholds:

* Disk: 80%
* Memory: 80%
* CPU: 80%
* Log retention: 7 days

## Future Phases

1. Linux & Shell
2. Networking
3. Git & GitHub
4. Docker
5. AWS
6. Terraform
7. CI/CD
8. Prometheus
9. Grafana
10. Platform integration and testing

## Goal

The final platform should allow developers to push application code and receive an automated, reproducible, containerized, deployed, and monitored environment with minimal manual infrastructure work.

