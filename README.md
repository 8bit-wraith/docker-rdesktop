# 🚀 Claude-Enhanced RDesktop - GPU-Accelerated Remote Desktop with AI

[![Claude Enhanced](https://img.shields.io/badge/Claude-Enhanced-6366f1?style=for-the-badge&logo=anthropic&logoColor=white)](https://claude.ai)
[![Nvidia GPU](https://img.shields.io/badge/Nvidia-GPU_Ready-76B900?style=for-the-badge&logo=nvidia&logoColor=white)](https://nvidia.com)
[![Coolify Ready](https://img.shields.io/badge/Coolify-Ready-0ea5e9?style=for-the-badge&logo=docker&logoColor=white)](https://coolify.io)

> **Fork of [linuxserver/docker-rdesktop](https://github.com/linuxserver/docker-rdesktop)** with Claude AI integration, enhanced GPU support, and Coolify deployment!

## ✨ What's New in This Fork

This fork adds powerful AI and GPU capabilities to the excellent LinuxServer.io RDesktop project:

- 🤖 **Claude CLI Auto-Configuration** - Set `ANTHROPIC_API_KEY` and Claude works instantly!
- 🎮 **Full Nvidia GPU Support** - CUDA, OpenGL, Vulkan with automatic detection
- 👤 **Custom User "hue"** - Changed from default "abc" for better personalization
- 🔐 **Auto Password Generation** - Secure random passwords on first run
- 🌊 **Coolify Integration** - Ready-to-deploy with proper labels and networking
- 🎯 **Desktop Shortcuts** - Quick access to Claude chat, code review, and GPU monitoring
- 🔊 **Enhanced Audio** - PulseAudio with equalizer and echo cancellation

## 🚀 Quick Start

### Option 1: Standard Docker Compose

```bash
# Clone this fork
git clone https://github.com/YOUR-USERNAME/docker-rdesktop.git
cd docker-rdesktop

# Build the Claude-enhanced image
./build-claude.sh

# Set your Claude API key (optional but recommended)
export ANTHROPIC_API_KEY="your-api-key"

# Run with GPU support
docker-compose -f docker-compose.claude.yml up -d
```

### Option 2: Deploy with Coolify

Use `docker-compose.coolify.yml` - password is auto-generated and Claude works instantly when you set the API key!

[📖 Full Coolify deployment guide](README-coolify.md)

## 🎯 Key Features

### Claude AI Integration
- **Instant Setup**: Just set `ANTHROPIC_API_KEY` - no login needed!
- **Desktop Shortcuts**: Quick access to Claude chat and code review
- **Pre-configured**: Optimal settings for development assistance

### GPU Acceleration
- **Nvidia Support**: Full CUDA, OpenGL, and Vulkan
- **Auto-Detection**: Configures GPU automatically
- **Gaming Ready**: Steam, Lutris pre-installed

### Enhanced Desktop
- **KDE Plasma**: Beautiful, GPU-accelerated desktop
- **Developer Tools**: VS Code, Neovim, multiple terminals
- **AI/ML Ready**: PyTorch, TensorFlow, Jupyter pre-installed

## 📋 Documentation

- [🤖 Claude Integration Guide](README-claude.md) - Full Claude CLI setup and usage
- [🌊 Coolify Deployment](README-coolify.md) - Deploy with auto-scaling and management
- [📖 Original LinuxServer Docs](#original-documentation) - Base container documentation

## 🔧 Configuration

### Essential Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ANTHROPIC_API_KEY` | Your Claude API key for instant setup | - |
| `RDP_PASSWORD` | Custom password (auto-generated if empty) | Random |
| `RDP_USERNAME` | Username for RDP login | `hue` |
| `PUID/PGID` | User/Group IDs | 1000 |
| `TZ` | Timezone | UTC |

### Connection Details
- **Protocol**: RDP (Remote Desktop Protocol)
- **Port**: 3389
- **Username**: `hue`
- **Password**: Check container logs or `/config/rdp-credentials.txt`

## 🎮 What's Included

### Development
- Claude CLI (auto-configured!)
- Python, Node.js, Go, Rust
- PyTorch, TensorFlow
- Git, Docker, dev tools

### Entertainment
- Steam & Lutris
- Discord
- OBS Studio
- GPU-accelerated games

### Desktop
- KDE Plasma with effects
- Multiple terminals
- System monitoring
- Customizable themes

---

# Original Documentation

Below is the original documentation from LinuxServer.io for the base rdesktop container:

---

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring:

* regular and timely application updates
* easy user mappings (PGID, PUID)
* custom base image with s6 overlay
* weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
* regular security updates

## Supported Architectures

We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://distribution.github.io/distribution/spec/manifest-v2-2/#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `lscr.io/linuxserver/rdesktop:latest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ✅ | arm64v8-\<version tag\> |
| armhf | ❌ | |

## Version Tags

This image provides various versions that are available via tags. Please read the descriptions carefully and exercise caution when using unstable or development tags.

| Tag | Available | Description |
| :----: | :----: |--- |
| latest | ✅ | XFCE Alpine |
| ubuntu-xfce | ✅ | XFCE Ubuntu |
| fedora-xfce | ✅ | XFCE Fedora |
| arch-xfce | ✅ | XFCE Arch |
| debian-xfce | ✅ | XFCE Debian |
| alpine-kde | ✅ | KDE Alpine |
| ubuntu-kde | ✅ | KDE Ubuntu |
| fedora-kde | ✅ | KDE Fedora |
| arch-kde | ✅ | KDE Arch |
| debian-kde | ✅ | KDE Debian |
| alpine-mate | ✅ | MATE Alpine |
| ubuntu-mate | ✅ | MATE Ubuntu |
| fedora-mate | ✅ | MATE Fedora |
| arch-mate | ✅ | MATE Arch |
| debian-mate | ✅ | MATE Debian |
| alpine-i3 | ✅ | i3 Alpine |
| ubuntu-i3 | ✅ | i3 Ubuntu |
| fedora-i3 | ✅ | i3 Fedora |
| arch-i3 | ✅ | i3 Arch |
| debian-i3 | ✅ | i3 Debian |
| alpine-openbox | ✅ | Openbox Alpine |
| ubuntu-openbox | ✅ | Openbox Ubuntu |
| fedora-openbox | ✅ | Openbox Fedora |
| arch-openbox | ✅ | Openbox Arch |
| debian-openbox | ✅ | Openbox Debian |
| alpine-icewm | ✅ | IceWM Alpine |
| ubuntu-icewm | ✅ | IceWM Ubuntu |
| fedora-icewm | ✅ | IceWM Fedora |
| arch-icewm | ✅ | IceWM Arch |
| debian-icewm | ✅ | IceWM Debian |

## Application Setup

**The Default USERNAME and PASSWORD is: abc/abc**

**Unlike our other containers these Desktops are not designed to be upgraded by Docker, you will keep your home directory but anything you installed system level will be lost if you upgrade an existing container. To keep packages up to date instead use Ubuntu's own apt, Alpine's apk, Fedora's dnf, or Arch's pacman program**

You will need a Remote Desktop client to access this container [Wikipedia List](https://en.wikipedia.org/wiki/Comparison_of_remote_desktop_software), by default it listens on 3389, but you can change that port to whatever you wish on the host side IE `3390:3389`.
The first thing you should do when you login to the container is to change the abc users password by issuing the `passwd` command.

**Modern GUI desktop apps (including some flavors terminals) have issues with the latest Docker and syscall compatibility, you can use Docker with the `--security-opt seccomp=unconfined` setting to allow these syscalls or try [podman](https://podman.io/) as they have updated their codebase to support them**

If you ever lose your password you can always reset it by execing into the container as root:

```bash
docker exec -it rdesktop passwd abc
```

By default we perform all logic for the abc user and we recommend using that user only in the container, but new users can be added as long as there is a `startwm.sh` executable script in their home directory.
All of these containers are configured with passwordless sudo, we make no efforts to secure or harden these containers and we do not recommend ever publishing their ports to the public Internet.

[Full original documentation continues below...]

## Support Info

* Shell access whilst the container is running:

    ```bash
    docker exec -it rdesktop /bin/bash
    ```

* To monitor the logs of the container in realtime:

    ```bash
    docker logs -f rdesktop
    ```

* Container version number:

    ```bash
    docker inspect -f '{{ index .Config.Labels "build_version" }}' rdesktop
    ```

* Image version number:

    ```bash
    docker inspect -f '{{ index .Config.Labels "build_version" }}' lscr.io/linuxserver/rdesktop:latest
    ```

## Credits

This fork builds upon the excellent work by:
- [LinuxServer.io](https://linuxserver.io) - Original rdesktop container
- [Anthropic](https://anthropic.com) - Claude AI integration
- [Nvidia](https://nvidia.com) - GPU drivers and CUDA toolkit

## License

This project inherits the license from the original LinuxServer.io docker-rdesktop project.