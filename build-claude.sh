#!/bin/bash

# Build script for Claude RDP with Nvidia GPU support

set -e

echo "🚀 Building Claude CLI RDP Environment with Nvidia GPU Support"
echo "============================================================"

# Check for Nvidia GPU
if ! command -v nvidia-smi &> /dev/null; then
    echo "⚠️  Warning: nvidia-smi not found. Nvidia GPU may not be available."
    echo "   Continue anyway? (y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check for Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker is not installed."
    exit 1
fi

# Check for Nvidia Container Toolkit
if ! docker info 2>/dev/null | grep -q "nvidia"; then
    echo "⚠️  Warning: Nvidia runtime not detected in Docker."
    echo "   Please install nvidia-container-toolkit."
    echo "   Continue anyway? (y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Build the image
echo ""
echo "📦 Building Docker image..."
docker build -f Dockerfile.claude-nvidia -t claude-rdp:latest \
    --build-arg BUILD_DATE=$(date +%Y%m%d) \
    --build-arg VERSION=1.0.0 \
    .

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build successful!"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Set your Claude API key (optional):"
    echo "      export ANTHROPIC_API_KEY='your-key-here'"
    echo ""
    echo "   2. Run the container:"
    echo "      docker-compose -f docker-compose.claude.yml up -d"
    echo ""
    echo "   3. Connect via RDP to localhost:3389"
    echo "      Username: abc"
    echo "      Password: abc (change it!)"
    echo ""
    echo "   4. Enjoy your GPU-accelerated Claude desktop! 🎮"
else
    echo ""
    echo "❌ Build failed!"
    exit 1
fi