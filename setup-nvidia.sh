#!/bin/bash

# Trisha's Amazing NVIDIA Setup Script! 🎮
# Because setting up NVIDIA shouldn't be a headache! 

echo "🌟 Welcome to the NVIDIA Setup Script!"
echo "--------------------------------------"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run as root (use sudo)"
    exit 1
fi

echo "🔍 Checking NVIDIA drivers..."
if ! command -v nvidia-smi &> /dev/null; then
    echo "❌ NVIDIA drivers not found! Please install NVIDIA drivers first."
    exit 1
fi
 
echo "✨ NVIDIA drivers found!"
nvidia-smi

echo "🔧 Installing NVIDIA Container Toolkit..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | apt-key add -
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

apt-get update
apt-get install -y nvidia-container-toolkit

echo "⚙️ Configuring NVIDIA runtime as default for Docker..."
nvidia-ctk runtime configure --runtime=docker --set-as-default

echo "🔄 Restarting Docker service..."
systemctl restart docker

echo "✅ Setup complete! Let's verify the installation..."
echo "----------------------------------------------"
echo "🔍 Docker info (looking for nvidia-container-runtime):"
docker info | grep -i nvidia

echo "
🎉 All done! You're ready to run the rdesktop container with NVIDIA support!

Next steps:
1. Build and run the container:
   docker compose up -d

2. Connect using any RDP client to localhost:3389
   Default credentials: abc/abc

3. Run the management script:
   docker exec rdesktop-nvidia manage.sh

Have fun! Remember what Trisha always says:
'Life is too short for slow rendering! 🚀'
"