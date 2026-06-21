#!/bin/bash
set -eux

ROOTFS=rootfs

sudo rm -rf "$ROOTFS"

sudo debootstrap \
  --arch=amd64 \
  trixie \
  "$ROOTFS" \
  http://deb.debian.org/debian

sudo cp scripts/chroot.sh "$ROOTFS/root/chroot.sh"

sudo mount --bind /dev "$ROOTFS/dev"
sudo mount --bind /proc "$ROOTFS/proc"
sudo mount --bind /sys "$ROOTFS/sys"

sudo chroot "$ROOTFS" /bin/bash /root/chroot.sh

sudo umount "$ROOTFS/dev"
sudo umount "$ROOTFS/proc"
sudo umount "$ROOTFS/sys"
