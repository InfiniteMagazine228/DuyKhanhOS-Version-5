#!/bin/bash
set -eux

apt update

apt install -y \
linux-image-amd64 \
live-boot \
live-config \
systemd-sysv \
sudo \
network-manager \
bash \
zsh \
curl \
wget \
git \
nano \
vim \
htop \
xfce4 \
xfce4-goodies \
xfce4-terminal \
thunar \
lightdm \
lightdm-gtk-greeter \
firefox-esr \
vlc \
gparted \
file-roller

useradd -m -s /bin/bash live || true

echo "live:live" | chpasswd

usermod -aG sudo live

apt clean
