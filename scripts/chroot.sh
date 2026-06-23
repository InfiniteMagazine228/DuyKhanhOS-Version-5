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
    xfce4-whiskermenu-plugin \
    thunar \
    mousepad \
    ristretto \
    lightdm \
    lightdm-gtk-greeter \
    firefox-esr \
    vlc \
    gparted \
    file-roller \
    pavucontrol \
    xfce4-power-manager \
    xfce4-screenshooter \
    plymouth \
    plymouth-themes \
    arc-theme \
    papirus-icon-theme \
    fonts-dejavu \
    calamares

# Locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Hostname
echo "DuyKhanhOS" > /etc/hostname

# Live user
useradd -m -s /bin/bash live || true

echo "live:live" | chpasswd

usermod -aG sudo,audio,video,plugdev,netdev live

# Passwordless sudo cho Live Session
echo "live ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/live
chmod 440 /etc/sudoers.d/live

# Display manager
mkdir -p /etc/X11

echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager

ln -sf \
    /lib/systemd/system/lightdm.service \
    /etc/systemd/system/display-manager.service

# Enable services
systemctl enable lightdm || true
systemctl enable NetworkManager || true

# Auto start Calamares nếu boot với tham số installer
cat > /usr/local/bin/start-installer << 'EOF'
#!/bin/bash

if grep -q installer /proc/cmdline; then
    sleep 5
    sudo calamares
fi
EOF

chmod +x /usr/local/bin/start-installer

mkdir -p /etc/xdg/autostart

cat > /etc/xdg/autostart/calamares.desktop << 'EOF'
[Desktop Entry]
Type=Application
Version=1.0
Name=DuyKhanhOS Installer
Exec=/usr/local/bin/start-installer
Terminal=false
NoDisplay=true
EOF

# Regenerate initramfs
update-initramfs -u

# Debug
ls -lah /boot

# Cleanup
apt clean
rm -rf /var/lib/apt/lists/*
