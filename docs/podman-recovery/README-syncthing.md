# Syncthing

This document describes the Syncthing deployment managed with Rootless Podman.

---

# Purpose

Syncthing provides continuous peer-to-peer synchronization between devices.

Within this deployment it is primarily used to synchronize data between mobile devices and the desktop.

---

# Deployment

Container Runtime

- Rootless Podman

Compose

- podman-compose

Image

- `docker.io/syncthing/syncthing:latest`

Lifecycle

- Manual

---

# Directory Layout

```text
~/Mains/
├── Phone-Backup/
└── Podman/
    ├── compose/
    │   └── syncthing/
    │       ├── compose.yml
    │       └── .env
    ├── configs/
    │   └── syncthing/
    │       └── config/
    └── data/
```

---

# Persistent Data

## Configuration

```text
~/Mains/Podman/configs/syncthing/config
```

Contains:

- Device IDs
- Folder configuration
- Certificates
- Keys
- Sync database

---

## User Data

Files synchronized by Syncthing are stored outside the Podman directory.

```text
~/Mains/Phone-Backup
```

This directory should be backed up independently.

---

# Container Management

Start:

```bash
syn-up
```

Stop:

```bash
syn-down
```

Start all managed applications:

```bash
file-up
```

Stop all managed applications:

```bash
file-down
```

---

# Logs

```bash
syn-logs
```

Or directly:

```bash
podman logs -f syncthing
```

---

# Updating

Pull the latest image.

```bash
podman-compose -f ~/Mains/Podman/compose/syncthing/compose.yml pull
```

Recreate the container.

```bash
podman-compose -f ~/Mains/Podman/compose/syncthing/compose.yml up -d
```

Verify synchronization and review the logs after updating.

---

# Backup

Back up:

```text
~/Mains/Podman/compose/syncthing
~/Mains/Podman/configs/syncthing
~/Mains/Phone-Backup
```

Container images and runtime state do not need to be backed up.

---

# Restore

1. Restore the compose files.
2. Restore the configuration directory.
3. Restore `~/Mains/Phone-Backup`.
4. Start the deployment.

```bash
syn-up
```

Syncthing should automatically recover all configured devices and folders.

---

# Notes

- Runs as Rootless Podman.
- Uses bind-mounted persistent storage.
- Uses the official Syncthing image.
- Managed manually; no restart policy or automatic startup is configured.
- Configuration is portable and can be restored on another machine without rebuilding the deployment.
