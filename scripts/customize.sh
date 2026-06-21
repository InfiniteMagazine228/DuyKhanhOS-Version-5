#!/bin/bash
set -eux

ROOTFS=rootfs

sudo mkdir -p \
"$ROOTFS/usr/share/backgrounds"

sudo cp config/wallpapers/cy.jpg \
"$ROOTFS/usr/share/backgrounds/cy.jpg"

sudo mkdir -p \
"$ROOTFS/home/live/.config/xfce4/xfconf/xfce-perchannel-xml"

if [ -f overlay/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml ]
then
    sudo cp \
    overlay/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml \
    "$ROOTFS/home/live/.config/xfce4/xfconf/xfce-perchannel-xml/"
fi

sudo chown -R 1000:1000 "$ROOTFS/home/live"
