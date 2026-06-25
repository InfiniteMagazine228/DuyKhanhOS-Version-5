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
plymouth \
plymouth-themes \
arc-theme \
papirus-icon-theme \
fonts-dejavu \
calamares \
calamares-settings-debian \
qt6-qpa-plugins \
libxcb-cursor0 \
libxkbcommon-x11-0 \
libxcb-icccm4 \
libxcb-image0 \
libxcb-keysyms1 \
libxcb-render-util0 \
libxcb-xinerama0 \
libxcb-xinput0

# Live user
useradd -m -s /bin/bash live || true

echo "live:live" | chpasswd

usermod -aG sudo live

echo "live ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/live
chmod 440 /etc/sudoers.d/live

# Hostname
echo DuyKhanhOS > /etc/hostname

# Locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# LightDM
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager

ln -sf /lib/systemd/system/lightdm.service \
       /etc/systemd/system/display-manager.service

systemctl enable lightdm || true
systemctl enable NetworkManager || true

# Installer autostart
cat > /usr/local/bin/start-installer << 'EOF'
#!/bin/bash

if grep -q installer /proc/cmdline; then
    sleep 5

    pkexec env \
        DISPLAY=$DISPLAY \
        XAUTHORITY=$XAUTHORITY \
        calamares
fi
EOF

chmod +x /usr/local/bin/start-installer

mkdir -p /etc/xdg/autostart

cat > /etc/xdg/autostart/calamares.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=DuyKhanhOS Installer
Exec=/usr/local/bin/start-installer
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF

update-initramfs -u

apt clean
rm -rf /var/lib/apt/lists/*
