#!/bin/bash
set -e

ROOTFS=rootfs

echo "Installing wallpaper..."

sudo mkdir -p $ROOTFS/usr/share/backgrounds

sudo cp config/wallpapers/cy.jpg \
$ROOTFS/usr/share/backgrounds/cy.jpg

echo "Creating XFCE config..."

sudo mkdir -p \
$ROOTFS/home/live/.config/xfce4/xfconf/xfce-perchannel-xml

sudo cp \
overlay/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml \
$ROOTFS/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/

echo "Fix ownership..."

sudo chroot $ROOTFS useradd -m -s /bin/bash live || true

echo "live:live" | sudo chroot $ROOTFS chpasswd

sudo chroot $ROOTFS usermod -aG sudo live

sudo chown -R 1000:1000 $ROOTFS/home/live

echo "Done."
