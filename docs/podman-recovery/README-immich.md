# Immich

This document describes the Immich deployment managed with Rootless Podman.

---

# Purpose

Immich provides self-hosted photo and video backup, organization, search, and machine learning features.

The deployment follows the official multi-container architecture with minimal changes for Rootless Podman.

---

# Deployment

Container Runtime

- Rootless Podman

Compose

- podman-compose

Application Components

- Immich Server
- PostgreSQL
- Valkey
- Immich Machine Learning

Lifecycle

- Manual

---

# Directory Layout

```text
~/Mains/Podman/
├── compose/
│   └── immich/
│       ├── compose.yml
│       └── .env
├── configs/
│   └── immich/
└── data/
    └── immich/
        ├── library/
        ├── postgres/
        └── ml-cache/
```

---

# Persistent Storage

## Library

```text
~/Mains/Podman/data/immich/library
```

Contains:

- Uploaded photos
- Uploaded videos
- Thumbnails
- Encoded media
- Backups
- User profiles

---

## PostgreSQL

```text
~/Mains/Podman/data/immich/postgres
```

Contains the Immich database.

---

## Machine Learning Cache

```text
~/Mains/Podman/data/immich/ml-cache
```

Contains downloaded AI models and caches.

---

# Container Management

Start:

```bash
imm-up
```

Stop:

```bash
imm-down
```

Start everything:

```bash
file-up
```

Stop everything:

```bash
file-down
```

---

# Logs

Immich Server

```bash
imm-logs
```

Any container

```bash
podman logs <container>
```

Follow logs

```bash
podman logs -f <container>
```

---

# Updating

Pull updated images.

```bash
podman-compose -f ~/Mains/Podman/compose/immich/compose.yml pull
```

Recreate containers.

```bash
podman-compose -f ~/Mains/Podman/compose/immich/compose.yml up -d
```

After updating:

- Confirm all four containers are running.
- Verify the web interface.
- Check logs if necessary.

Review upstream release notes before major version upgrades.

---

# Backup

Back up:

```text
~/Mains/Podman/compose/immich
~/Mains/Podman/configs/immich
~/Mains/Podman/data/immich
```

Do not back up:

- Images
- Containers
- Networks
- Podman runtime storage

These are recreated automatically.

---

# Restore

1. Restore the compose files.
2. Restore configuration.
3. Restore the data directory.
4. Start the deployment.

```bash
imm-up
```

Immich should automatically reuse the existing database, library, and machine learning cache.

---

# Notes

- Runs as Rootless Podman.
- Uses bind-mounted persistent storage.
- Uses official Immich images.
- Uses PostgreSQL and Valkey as separate containers.
- Managed manually; no restart policy or automatic startup is configured.
- The deployment can be restored by restoring the compose files, configuration, and persistent data.
