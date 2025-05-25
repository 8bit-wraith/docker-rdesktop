#!/bin/bash

# Combine env
/usr/bin/with-contenv /usr/bin/env | sed 's/^/export /g' > /defaults/env.sh
source /defaults/env.sh
rm /defaults/env.sh

# Enable Nvidia GPU support if detected
if which nvidia-smi > /dev/null 2>&1; then
  echo "**** Configuring Nvidia GPU support ****"
  export NVIDIA_VISIBLE_DEVICES=all
  export NVIDIA_DRIVER_CAPABILITIES=all
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json
  
  # Log GPU info
  nvidia-smi
fi

# Start enhanced PulseAudio with better quality
echo "**** Starting enhanced PulseAudio ****"
pulseaudio --kill 2>/dev/null || true
pulseaudio --start --log-target=syslog --realtime --disallow-exit --disallow-module-loading=0

# Set audio quality
pactl set-sink-volume @DEFAULT_SINK@ 75%
pactl set-sink-mute @DEFAULT_SINK@ 0

# Start compositor for better visuals
if which picom > /dev/null 2>&1; then
  picom --experimental-backends --backend glx --vsync &
elif which compton > /dev/null 2>&1; then
  compton --backend glx --vsync opengl &
fi

# Launch Plank dock for a fun interface
if which plank > /dev/null 2>&1; then
  plank &
fi

# Start Conky for system monitoring
if which conky > /dev/null 2>&1; then
  sleep 5 && conky &
fi

# Set wallpaper using variety
if which variety > /dev/null 2>&1; then
  variety --resume &
fi

# Configure KDE for performance with GPU
if [ "$DESKTOP_SESSION" = "plasma" ]; then
  # Enable desktop effects with OpenGL
  kwriteconfig5 --file kwinrc --group Compositing --key Backend OpenGL
  kwriteconfig5 --file kwinrc --group Compositing --key GLCore true
  kwriteconfig5 --file kwinrc --group Compositing --key GLPreferBufferSwap a
  
  # Enable smooth animations
  kwriteconfig5 --file kdeglobals --group KDE --key AnimationDurationFactor 1
fi

# Create desktop shortcuts for fun apps
mkdir -p ~/Desktop
cat > ~/Desktop/claude-chat.desktop <<'EOL'
[Desktop Entry]
Version=1.0
Type=Application
Name=Claude Chat
Comment=Chat with Claude AI
Exec=kitty -e claude chat
Icon=applications-internet
Terminal=false
Categories=Development;
EOL

cat > ~/Desktop/gpu-monitor.desktop <<'EOL'
[Desktop Entry]
Version=1.0
Type=Application
Name=GPU Monitor
Comment=Monitor Nvidia GPU
Exec=kitty -e watch -n 1 nvidia-smi
Icon=nvidia-settings
Terminal=false
Categories=System;
EOL

chmod +x ~/Desktop/*.desktop

# Auto-start terminal with welcome message
if which kitty > /dev/null 2>&1; then
  kitty -e bash -c "claude-welcome; exec bash" &
elif which alacritty > /dev/null 2>&1; then
  alacritty -e bash -c "claude-welcome; exec bash" &
else
  xterm -e bash -c "claude-welcome; exec bash" &
fi

# Launch the desktop environment
echo "**** Starting desktop environment ****"
exec /usr/bin/startplasma-x11