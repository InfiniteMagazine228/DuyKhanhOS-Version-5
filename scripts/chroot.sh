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
polkitd \
pkexec \
accountsservice \
locales \
ca-certificates \
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
file-roller \
plymouth \
plymouth-themes \
calamares

# Create live user
useradd -m -s /bin/bash live || true

echo "live:live" | chpasswd

usermod -aG sudo live

# Hostname
echo "DuyKhanhOS" > /etc/hostname

# Locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Set LightDM as default display manager
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager

ln -sf /lib/systemd/system/lightdm.service \
/etc/systemd/system/display-manager.service

# Enable services
systemctl enable lightdm || true
systemctl enable NetworkManager || true

# Cleanup
apt clean
rm -rf /var/lib/apt/lists/*
