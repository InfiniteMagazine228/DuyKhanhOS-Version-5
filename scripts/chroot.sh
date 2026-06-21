#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

apt update

apt install -y \
linux-image-amd64 \
live-boot \
live-config \
systemd-sysv \
sudo \
network-manager \
dbus-x11 \
xorg \
xinit \
bash \
zsh \
curl \
wget \
git \
nano \
vim \
htop \
locales \
ca-certificates \
xfce4 \
xfce4-goodies \
xfce4-terminal \
thunar \
lightdm \
lightdm-gtk-greeter \
firefox-esr \
vlc \
gparted \
file-roller \
plymouth \
plymouth-themes

# Create live user
useradd -m -s /bin/bash live || true

echo "live:live" | chpasswd

usermod -aG sudo live

# Hostname
echo "DuyKhanhOS" > /etc/hostname

# Enable services
systemctl enable lightdm || true
systemctl enable NetworkManager || true

apt clean

rm -rf /var/lib/apt/lists/*
