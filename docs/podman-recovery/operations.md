# Podman Operations

This document describes the routine operations used to manage all Podman applications.

---

# Philosophy

Applications are managed manually.

There is:

- No automatic startup
- No automatic restart policy
- No Quadlets
- No Podman systemd services

The user explicitly controls when applications start, stop, update, and restart.

---

# Managed Applications

Current applications:

- Syncthing
- Immich

Immich consists of:

- Immich Server
- PostgreSQL
- Valkey
- Machine Learning

---

# Daily Management

## Start Everything

```bash
file-up
```

Starts all managed applications.

---

## Stop Everything

```bash
file-down
```

Stops all managed applications.

---

## Start One Application

### Syncthing

```bash
syn-up
```

### Immich

```bash
imm-up
```

---

## Stop One Application

### Syncthing

```bash
syn-down
```

### Immich

```bash
imm-down
```

---

# Status

Running containers:

```bash
podman ps
```

All containers:

```bash
podman ps -a
```

Images:

```bash
podman images
```

Networks:

```bash
podman network ls
```

System usage:

```bash
podman system df
```

---

# Logs

## Syncthing

```bash
syn-logs
```

## Immich

```bash
imm-logs
```

Or use Podman directly.

```bash
podman logs <container>
```

Follow logs:

```bash
podman logs -f <container>
```

---

# Shell Access

Open a shell inside a running container.

```bash
podman exec -it <container> sh
```

If Bash exists:

```bash
podman exec -it <container> bash
```

---

# Updates

For a single application:

```bash
podman-compose -f ~/Mains/Podman/compose/<application>/compose.yml pull
podman-compose -f ~/Mains/Podman/compose/<application>/compose.yml up -d
```

After updating:

- Verify containers started.
- Review logs if required.
- Confirm the application functions correctly.

Review upstream release notes before major upgrades.

---

# Configuration Changes

After editing:

- `compose.yml`
- `.env`

Validate:

```bash
podman-compose -f ~/Mains/Podman/compose/<application>/compose.yml config
```

If validation succeeds:

```bash
podman-compose -f ~/Mains/Podman/compose/<application>/compose.yml up -d
```

---

# Health Checks

Verify running containers.

```bash
podman ps
```

Inspect a container.

```bash
podman inspect <container>
```

View logs.

```bash
podman logs <container>
```

---

# Cleanup

Unused images:

```bash
podman image prune
```

Unused containers:

```bash
podman container prune
```

Unused networks:

```bash
podman network prune
```

Always review what will be removed before confirming.

---

# Storage

Disk usage:

```bash
podman system df
```

General information:

```bash
podman info
```

---

# Adding an Application

New applications should follow the existing architecture.

```text
compose/<application>/
configs/<application>/
data/<application>/
```

Requirements:

- Rootless Podman
- podman-compose
- Official images whenever practical
- Bind-mounted persistent storage
- Manual lifecycle

Each application should include its own README.

---

# Troubleshooting

Validate the Compose configuration.

```bash
podman-compose -f ~/Mains/Podman/compose/<application>/compose.yml config
```

Check container status.

```bash
podman ps -a
```

Inspect logs.

```bash
podman logs <container>
```

Inspect configuration.

```bash
podman inspect <container>
```

Verify host file ownership.

```bash
ls -lah
```

Change one thing at a time and verify the result before making additional changes.

---

# Operational Principles

- Keep Compose files close to upstream.
- Prefer bind mounts over named volumes.
- Avoid unnecessary customization.
- Do not modify application-managed files manually.
- Verify changes before deployment.
- Keep documentation synchronized with the deployment.
- Prefer explicit manual operations over automation.
