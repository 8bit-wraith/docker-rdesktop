# Claude RDP for Coolify with Nvidia GPU

A Coolify-ready RDP desktop environment with Claude CLI, Nvidia GPU support, and automatic password generation!

## 🚀 Features

- **Coolify Compatible** - Ready to deploy with proper labels and networking
- **Auto Password Generation** - Random secure password on first run
- **User "hue"** - Custom username instead of default "abc"
- **Full Nvidia GPU Support** - CUDA, OpenGL, Vulkan acceleration
- **Claude CLI Integration** - Pre-installed and ready
- **Persistent Storage** - Named volumes for config and home directory

## 📋 Coolify Deployment

### 1. Prerequisites on Coolify Server

```bash
# Install Nvidia Container Toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker

# Configure Docker runtime
sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
sudo systemctl restart docker
```

### 2. Deploy in Coolify

1. **Create New Service** → Choose "Docker Compose"

2. **Paste the compose file**: `docker-compose.coolify.yml`

3. **Set Environment Variables** in Coolify:
   ```
   ANTHROPIC_API_KEY=your-claude-api-key  # ✨ Claude works instantly!
   SERVICE_USER_PUID=1000
   SERVICE_USER_PGID=1000
   TZ=America/New_York
   ```

4. **Configure Network**: Make sure to use Coolify's network

5. **Deploy!** The password will be auto-generated

### 3. Access Your Desktop

After deployment, Coolify will show:
- **Connection URL**: `your-domain.com:3389`
- **Username**: `hue`
- **Password**: Check logs or `/config/rdp-credentials.txt`

## 🔐 Password Management

### Automatic Generation
On first run, a random 12-character password is generated and saved to:
- `/config/rdp-credentials.txt` (inside container)
- Container logs (visible in Coolify)

### Manual Password Setting
Set a specific password via Coolify environment:
```
SERVICE_PASSWORD_CLAUDE_RDP=YourSecurePassword123!
```

### Reset Password
```bash
# Via Coolify terminal or SSH
docker exec -it claude-rdp-your-domain passwd hue
```

## 📁 Persistent Storage

Coolify creates named volumes:
- `claude-rdp-config-{domain}` - Configuration files
- `claude-rdp-home-{domain}` - User home directory

Data persists across container updates!

## 🎮 Using the Desktop

### First Login
1. Connect with any RDP client to `your-domain:3389`
2. Login with username `hue` and the generated password
3. A welcome screen shows GPU status and helpful info

### Claude CLI

#### Automatic Configuration ✨
If you set `ANTHROPIC_API_KEY` in Coolify, Claude is ready immediately!
```bash
# Just start chatting - no login needed!
claude chat

# Ask questions directly
claude "How do I optimize this PyTorch model?"

# Get coding help
claude "Write a Python function to detect GPU memory usage"
```

#### Manual Configuration
If you didn't set the API key in environment:
```bash
# Login with your API key
claude auth login

# Then start using Claude
claude chat
```

### GPU Testing
```bash
# Check GPU
nvidia-smi

# Test CUDA
python3 -c "import torch; print(torch.cuda.is_available())"

# Run GPU benchmark
glxgears
```

## 🛠️ Coolify-Specific Features

### Health Checks
The container includes health checks for:
- Nvidia GPU availability
- XRDP service status

### Traefik Integration
Proper labels for Traefik TCP routing are included for RDP protocol.

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVICE_FQDN_CLAUDE_RDP_3389` | Your domain (set by Coolify) | Auto |
| `SERVICE_PASSWORD_CLAUDE_RDP` | RDP password | Random |
| `ANTHROPIC_API_KEY` | Claude API key | None |
| `SERVICE_USER_PUID` | User ID | 1000 |
| `SERVICE_USER_PGID` | Group ID | 1000 |
| `TZ` | Timezone | UTC |

### Scaling
To run multiple instances, Coolify will handle:
- Unique container names
- Separate volumes per instance
- Different ports/domains

## 🔧 Troubleshooting

### Can't Connect
1. Check Coolify logs for the password
2. Ensure port 3389 is open in firewall
3. Verify container is healthy in Coolify

### GPU Not Working
1. Check host has Nvidia drivers: `nvidia-smi`
2. Verify Docker runtime: `docker info | grep nvidia`
3. Check container logs for GPU initialization

### Password Issues
1. Check `/config/rdp-credentials.txt` via Coolify terminal
2. Look for password in deployment logs
3. Reset manually if needed

## 🚀 Advanced Usage

### Custom Build Args
In Coolify, you can override build arguments:
```
BUILD_DATE=2024-01-01
VERSION=1.0.0
```

### GPU Selection
For multi-GPU systems, set in Coolify env:
```
NVIDIA_VISIBLE_DEVICES=0,1  # Use specific GPUs
```

### Performance Tuning
```
__GL_SYNC_TO_VBLANK=0
__GL_SHADER_DISK_CACHE_SIZE=10737418240
```

Enjoy your Coolify-deployed Claude desktop! 🎉