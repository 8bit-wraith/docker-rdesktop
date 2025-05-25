# Claude CLI RDP Environment with Nvidia GPU

A fun, GPU-accelerated remote desktop environment with Claude CLI integration, enhanced audio, and tons of development and entertainment tools!

## Features

- 🚀 **Full Nvidia GPU Support** - CUDA, OpenGL, Vulkan acceleration
- 🤖 **Claude CLI Integration** - Chat with Claude directly from the desktop
- 🔊 **Enhanced Audio** - High-quality PulseAudio with echo cancellation
- 🎮 **Gaming Ready** - Steam, Lutris, and GPU-accelerated games
- 💻 **Development Tools** - Full dev environment with multiple languages
- 🎨 **Beautiful Desktop** - KDE Plasma with compositor effects
- 🛠️ **AI/ML Ready** - PyTorch, TensorFlow, CUDA toolkit pre-installed

## Prerequisites

1. **Nvidia GPU with drivers installed** on the host system
2. **Docker with Nvidia Container Toolkit**:
   ```bash
   # Install Nvidia Container Toolkit
   distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
   curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
   curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
   
   sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
   sudo systemctl restart docker
   
   # Configure Docker to use Nvidia runtime by default
   sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
   sudo systemctl restart docker
   ```

3. **RDP Client** - Any RDP client (Windows Remote Desktop, Remmina, etc.)

## Quick Start

1. **Clone and build**:
   ```bash
   git clone https://github.com/linuxserver/docker-rdesktop.git
   cd docker-rdesktop
   
   # Build the Claude-enabled image
   docker build -f Dockerfile.claude-nvidia -t claude-rdp:latest .
   ```

2. **Set up your API key** (optional):
   ```bash
   export ANTHROPIC_API_KEY="your-claude-api-key-here"
   ```

3. **Run with docker-compose**:
   ```bash
   docker-compose -f docker-compose.claude.yml up -d
   ```

4. **Connect via RDP**:
   - Server: `localhost:3389`
   - Username: `abc`
   - Password: `abc` (change it immediately!)

## First Time Setup

1. **Change the default password**:
   ```bash
   docker exec -it claude-rdp passwd abc
   ```

2. **Configure Claude CLI** (if API key not set via environment):
   ```bash
   # Inside the container
   claude auth login
   ```

3. **Test GPU acceleration**:
   ```bash
   # Check Nvidia GPU
   nvidia-smi
   
   # Test Vulkan
   vulkaninfo
   
   # Test CUDA
   nvcc --version
   ```

## What's Included

### Development Tools
- **Languages**: Python 3, Node.js, Go, Rust, C/C++
- **Editors**: Neovim, VS Code (installable), Vim
- **Terminals**: Kitty, Alacritty, Terminator
- **AI/ML**: PyTorch, TensorFlow, Jupyter, CUDA

### Entertainment
- **Gaming**: Steam, Lutris, SuperTuxKart, 0 A.D., Minetest
- **Media**: VLC, MPV, OBS Studio
- **Communication**: Discord

### Desktop Environment
- **KDE Plasma** with GPU-accelerated effects
- **Plank** dock for quick app access
- **Conky** for system monitoring
- **Variety** for wallpaper management

## Usage Examples

### Chat with Claude
```bash
# Start an interactive chat
claude chat

# Ask a specific question
claude "How do I optimize my PyTorch model for GPU?"

# Use Claude for code review
claude review mycode.py
```

### GPU-Accelerated Development
```python
# Test PyTorch GPU
import torch
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"GPU: {torch.cuda.get_device_name(0)}")

# Run on GPU
tensor = torch.randn(1000, 1000).cuda()
result = torch.matmul(tensor, tensor)
```

### Gaming with GPU
- Launch Steam from the application menu
- Enable Proton for Windows games
- Use Lutris for non-Steam games
- GPU acceleration works out of the box!

## Performance Tips

1. **Adjust shared memory** in docker-compose.yml if running large models
2. **Enable GPU persistence**:
   ```bash
   docker exec -it claude-rdp nvidia-smi -pm 1
   ```
3. **Monitor GPU usage** with the desktop shortcut or:
   ```bash
   watch -n 1 nvidia-smi
   ```

## Troubleshooting

### No GPU detected
- Ensure Nvidia drivers are installed on host
- Check Docker runtime: `docker info | grep nvidia`
- Verify GPU visibility: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`

### Audio issues
- Restart PulseAudio: `pulseaudio -k && pulseaudio --start`
- Check audio devices: `pactl list sinks`
- Adjust volume: `pavucontrol`

### Claude CLI not working
- Ensure API key is set: `echo $ANTHROPIC_API_KEY`
- Re-authenticate: `claude auth login`
- Update Claude CLI: `npm update -g @anthropic-ai/claude-cli`

## Advanced Configuration

### Custom Nvidia settings
Edit the docker-compose.yml to add more Nvidia environment variables:
```yaml
environment:
  - CUDA_CACHE_MAXSIZE=10737418240  # 10GB CUDA cache
  - TF_FORCE_GPU_ALLOW_GROWTH=true   # TensorFlow memory growth
  - PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512
```

### Multiple GPUs
Modify the deploy section:
```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          device_ids: ['0', '1']  # Specific GPUs
          capabilities: [gpu]
```

## Security Notes

- Change the default password immediately
- Consider using SSH keys instead of password auth
- Use firewall rules to restrict RDP access
- Keep your Nvidia drivers and Docker updated

Enjoy your GPU-accelerated Claude desktop! 🚀