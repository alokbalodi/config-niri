# Backup and Restore

This document describes the backup and recovery strategy for all Podman applications.

---

# Philosophy

The deployment is designed so every application can be restored without rebuilding it manually.

Persistent data is intentionally stored outside Podman's internal storage using bind mounts whenever practical.

A complete backup consists of:

- Deployment files
- Application configuration
- Persistent application data
- User data stored outside the Podman directory

Restoring these components should be sufficient to return every application to its previous operational state.

---

# What to Back Up

## compose/

```text
~/Mains/Podman/compose
```

Contains:

- `compose.yml`
- `.env`

These files define how every application is deployed.

---

## configs/

```text
~/Mains/Podman/configs
```

Contains persistent application configuration.

Current examples:

- Syncthing configuration (`configs/syncthing/config/`)
- TLS certificates
- Application configuration

---

## data/

```text
~/Mains/Podman/data
```

Contains persistent application data.

Current examples:

- Immich photo library
- PostgreSQL database
- Machine Learning cache

---

## External User Data

Some user data intentionally resides outside the Podman directory.

Current example:

```text
~/Mains/Phone-Backup
```

This directory must also be included in backups.

---

# What Does Not Need to Be Backed Up

Do not back up:

- Containers
- Images
- Networks
- Podman cache
- Podman internal storage
- Runtime state

These are recreated when the deployment is restored.

---

# Restore Procedure

## 1. Restore Files

Restore:

```text
~/Mains/Podman
```

Restore any external user-data directories.

Example:

```text
~/Mains/Phone-Backup
```

---

## 2. Verify

Confirm:

- Compose files exist.
- `.env` files exist.
- Configuration directories exist.
- Data directories exist.

Review `.env` files if credentials or host paths have changed.

---

## 3. Start Applications

Start every managed application.

```bash
file-up
```

Or start an individual application.

```bash
syn-up
```

```bash
imm-up
```

Applications should automatically reuse their existing configuration and persistent data.

---

# Migration

To migrate to another machine:

1. Install Arch Linux.
2. Install Rootless Podman.
3. Install `podman-compose`.
4. Restore `~/Mains/Podman`.
5. Restore `~/Mains/Phone-Backup`.
6. Restore the configuration repository.
7. Run `file-up`.

No application should require reinstallation or manual reconstruction.

---

# Verification

After restoring, verify:

- Containers start successfully.
- Web interfaces are accessible.
- Existing data is present.
- Databases load correctly.
- Syncthing resumes synchronization.
- Immich library and AI models are available.

---

# Recommendations

- Keep backups versioned.
- Verify backups periodically.
- Test recovery procedures.
- Keep documentation together with backups.
- Review backups before major upgrades.

---

# Recovery Goals

A successful backup should recover:

- Deployment files
- Environment files
- Application configuration
- Persistent application data
- External user data

without rebuilding containers or repeating the original installation process.

The goal is that restoring the backup and running `file-up` returns the deployment to its previous operational state.
