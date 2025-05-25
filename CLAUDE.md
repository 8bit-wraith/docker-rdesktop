# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

docker-rdesktop is a LinuxServer.io container that provides full desktop environments accessible via RDP (Remote Desktop Protocol). It supports multiple desktop environments (XFCE, KDE, MATE, i3, Openbox, IceWM) and operating systems (Alpine, Ubuntu, Fedora, Arch, Debian).

## Key Commands

### Building the Container

```bash
# Build for x86_64
docker build --no-cache --pull -t lscr.io/linuxserver/rdesktop:latest .

# Build for ARM64
docker build --no-cache --pull -t lscr.io/linuxserver/rdesktop:latest -f Dockerfile.aarch64 .
```

### Running the Container

```bash
# Basic run command
docker run -d \
  --name=rdesktop \
  --security-opt seccomp=unconfined \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3389:3389 \
  -v /path/to/config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/rdesktop:latest
```

### Accessing the Container

- Default RDP port: 3389
- Default username/password: abc/abc
- Reset password: `docker exec -it rdesktop passwd abc`

## Architecture

### Base Image
- Uses `ghcr.io/linuxserver/baseimage-rdesktop` as the foundation
- Separate Dockerfiles for different architectures (Dockerfile for amd64, Dockerfile.aarch64 for arm64)

### Key Components
- **Desktop Environment**: XFCE4 (in the default Alpine image)
- **Remote Access**: XRDP server for RDP connectivity
- **Audio Support**: PulseAudio (started via `/startpulse.sh`)
- **Window Manager**: Configured via `/defaults/startwm.sh`

### Important Paths
- `/config`: User home directory (persistent storage)
- `/defaults/startwm.sh`: Desktop environment startup script
- `/build_version`: Contains version information

### Environment Variables
- `PUID/PGID`: User/Group IDs for permission management
- `TZ`: Timezone configuration
- `LC_ALL`: Language/locale settings
- `NO_DECOR`: Run applications without window borders
- `NO_FULL`: Disable automatic fullscreen in openbox

## Development Notes

### Tag Structure
- `latest`: XFCE Alpine (default)
- `{os}-{desktop}`: Specific OS and desktop combinations (e.g., `ubuntu-xfce`, `fedora-kde`)

### GPU Support
- Open Source drivers: Mount with `--device /dev/dri:/dev/dri`
- Nvidia: Use `--gpus all --runtime nvidia` (not compatible with Alpine)

### Package Management
- Alpine: Use `apk`
- Ubuntu/Debian: Use `apt`
- Fedora: Use `dnf`
- Arch: Use `pacman`

Note: System-level packages are not preserved during container upgrades. Use proot-apps for persistent application installations.