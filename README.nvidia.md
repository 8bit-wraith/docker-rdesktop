# RDesktop with NVIDIA GPU Support and VSCodium 🚀

This is an enhanced version of the rdesktop container with NVIDIA GPU support and VSCodium IDE integration, running on KDE Ubuntu.

## Features ✨

- 🖥️ KDE Ubuntu Desktop Environment
- 🎮 NVIDIA GPU Support with CUDA toolkit
- 📝 VSCodium IDE
- 🎨 Full GPU acceleration
- 🛠️ Fun management scripts

## Prerequisites

1. Docker installed
2. NVIDIA GPU with appropriate drivers
3. NVIDIA Container Toolkit installed
4. Docker Compose installed

## Quick Start 🚀

1. Build and start the container:
```bash
docker-compose up -d
```

2. Connect using any RDP client to localhost:3389

Default credentials:
- Username: abc
- Password: abc

## Management Scripts 🔧

The container comes with Trisha's Awesome Management Script! To use it:

```bash
docker exec rdesktop-nvidia manage.sh
```

This will show you a fun menu with options to:
- 🚀 Start Container
- 🛑 Stop Container
- 🔄 Restart Container
- 🔍 Check GPU Status
- 🎨 Test Display

## Checking GPU Status 🎮

You can check your GPU status anytime:

```bash
docker exec rdesktop-nvidia check-gpu
```

## VSCodium 📝

VSCodium is pre-installed and can be launched from the KDE menu or terminal:
```bash
codium
```

## Environment Variables

| Variable | Function | Default |
|----------|----------|---------|
| PUID | User ID | 1000 |
| PGID | Group ID | 1000 |
| TZ | Timezone | UTC |
| DISPLAY_WIDTH | Screen Width | 1920 |
| DISPLAY_HEIGHT | Screen Height | 1080 |
| KEYBOARD | Keyboard Layout | en-us-qwerty |

## GPU Configuration 🎮

The container is configured to use all available NVIDIA GPUs with full capabilities. You can modify the GPU settings in docker-compose.yml:

```yaml
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
```

## Volumes 📁

- `/config`: Persistent storage for settings
- `/tmp/.X11-unix`: X11 socket for display

## Port 🌐

- 3389: RDP port

## Contributing 🤝

Feel free to submit issues and enhancement requests!

## Notes 📝

- The container uses the NVIDIA runtime by default
- GPU support requires the host system to have NVIDIA drivers installed
- For best performance, ensure your RDP client supports hardware acceleration

## Troubleshooting 🔍

1. If you can't see the GPU in the container:
   ```bash
   docker exec rdesktop-nvidia nvidia-smi
   ```

2. If display is not working:
   ```bash
   docker exec rdesktop-nvidia glxgears
   ```

Remember to have fun! As Trisha always says, "A day without GPU acceleration is like a day without sunshine! ☀️"