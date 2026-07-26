# Podman Architecture

This document describes the architecture, design principles, and conventions used for all Podman applications.

---

# Philosophy

The deployment follows these principles:

- Rootless Podman only
- Native Podman workflow
- Official container images whenever practical
- Compose files remain close to upstream
- Manual lifecycle
- Simplicity over cleverness
- Predictable directory layout
- Bind-mounted persistent storage
- Long-term maintainability

The objective is a deployment that is easy to understand, reproduce, maintain, and recover.

---

# Platform

Host Operating System

- Arch Linux

Container Runtime

- Rootless Podman 6

Compose Implementation

- podman-compose

Networking

- Netavark
- Aardvark DNS
- Pasta (rootless networking)

OCI Runtime

- crun

Logging

- journald

---

# Directory Layout

All applications follow the same directory layout.

```text
~/Mains/
├── Phone-Backup/
└── Podman/
    ├── compose/
    │   ├── immich/
    │   └── syncthing/
    ├── configs/
    │   ├── immich/
    │   └── syncthing/
    │       └── config/
    ├── data/
    │   └── immich/
    └── backups/
```

Each directory has a single responsibility.

---

# compose/

Contains deployment files for each application.

Typical contents:

```text
compose/<application>/
├── compose.yml
└── .env
```

No application data is stored here.

---

# configs/

Contains persistent application configuration managed outside containers.

Current usage:

- Syncthing configuration (`configs/syncthing/config/`)
- Immich configuration (reserved)

The official Syncthing container stores its configuration under `/var/syncthing/config`, so the host bind mount intentionally mirrors this layout.

---

# data/

Contains persistent application data.

Current usage:

```text
data/
└── immich/
    ├── library/
    ├── postgres/
    └── ml-cache/
```

Application-managed data remains inside these bind-mounted directories.

---

# backups/

Reserved for exported backups and recovery archives.

Backups should be staged here before being copied elsewhere.

---

# Application Layout

Every application follows the same structure.

```text
compose/<application>/
configs/<application>/
data/<application>/
```

Applications that do not require every directory may leave it empty to preserve a consistent layout.

---

# Images

Whenever practical:

- Official images are preferred.
- Community images are only used when no official image exists.

Current deployment:

- Syncthing
- Immich Server
- Immich Machine Learning
- Immich PostgreSQL
- Valkey

---

# Compose Files

Compose files remain as close as possible to upstream.

Only minimal changes are made to:

- Use bind mounts
- Support rootless Podman
- Match the repository layout

Unnecessary customization is avoided.

---

# Persistent Storage

Persistent data is intentionally stored outside Podman's internal storage.

Bind mounts are preferred for:

- Application data
- Databases
- Configuration
- AI models

This simplifies:

- Backups
- Inspection
- Migration
- Recovery

No named volumes are used.

---

# Rootless Podman

All applications run as the normal user.

Benefits include:

- No root daemon
- Better isolation
- User-owned data
- Simpler recovery

Host data should remain accessible without ownership workarounds.

---

# Lifecycle

Applications are managed manually.

Primary helper commands:

```text
file-up
file-down
imm-up
imm-down
imm-logs
syn-up
syn-down
syn-logs
```

There are:

- No Quadlets
- No container restart policies
- No automatic startup

The user explicitly controls when services start and stop.

---

# Updates

General workflow:

1. Review release notes.
2. Pull updated images.
3. Recreate containers.
4. Verify application functionality.

Major upgrades should always be reviewed before deployment.

---

# Recovery

A deployment is recoverable from:

- Compose files
- Environment files
- Configuration
- Persistent data

No application should require manual reconstruction after recovery.

---

# Documentation

Documentation is divided into:

- architecture.md
- operations.md
- backup.md
- README-immich.md
- README-syncthing.md

Global platform documentation remains here, while application-specific details remain in each application's README.

---

# Design Goals

The architecture prioritizes:

- Consistency
- Reproducibility
- Simplicity
- Minimal upstream deviation
- Predictable storage
- Explicit operations over automation
- Straightforward recovery
