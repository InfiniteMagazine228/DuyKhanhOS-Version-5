#!/bin/bash
set -e

ROOTFS=rootfs

sudo debootstrap \
--arch=amd64 \
trixie \
$ROOTFS \
http://deb.debian.org/debian

sudo cp scripts/chroot.sh $ROOTFS/root/

sudo chroot $ROOTFS chmod +x /root/chroot.sh
sudo chroot $ROOTFS /root/chroot.sh
