#!/bin/bash
set -eux

export DEBIAN_FRONTEND=noninteractive

apt update

apt install -y \
linux-image-amd64 \
initramfs-tools \
live-boot \
live-config \
systemd-sysv \
sudo \
network-manager \
network-manager-gnome \
dbus-x11 \
xorg \
xinit \
polkitd \
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
mousepad \
ristretto \
plymouth \
plymouth-themes \
calamares

# Create live user
useradd -m -s /bin/bash live || true

echo "live:live" | chpasswd

usermod -aG sudo live

# Hostname
echo DuyKhanhOS > /etc/hostname

# Locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Display manager
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager

ln -sf /lib/systemd/system/lightdm.service \
/etc/systemd/system/display-manager.service

# Enable services
systemctl enable lightdm || true
systemctl enable NetworkManager || true

# Generate initramfs
update-initramfs -u

# Debug
ls -lah /boot

apt clean

rm -rf /var/lib/apt/lists/*
mkdir -p /etc/xdg/autostart
# Auto start installer if booted with installer option

cat > /usr/local/bin/start-installer << 'EOF'
#!/bin/bash

if grep -q installer /proc/cmdline; then
    sleep 5
    pkexec calamares
fi
EOF

chmod +x /usr/local/bin/start-installer

mkdir -p /etc/xdg/autostart

cat > /etc/xdg/autostart/calamares.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Calamares
Exec=/usr/local/bin/start-installer
NoDisplay=true
EOF
