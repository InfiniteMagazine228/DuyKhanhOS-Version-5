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

# DNS
sudo cp /etc/resolv.conf "$ROOTFS/etc/resolv.conf"

# Mount
sudo mount --bind /dev "$ROOTFS/dev"
sudo mount --bind /dev/pts "$ROOTFS/dev/pts"
sudo mount -t proc proc "$ROOTFS/proc"
sudo mount -t sysfs sys "$ROOTFS/sys"
sudo mount -t tmpfs tmpfs "$ROOTFS/run"

# Chroot
sudo chroot "$ROOTFS" /bin/bash /root/chroot.sh

# Cleanup
sudo umount -lf "$ROOTFS/dev/pts" || true
sudo umount -lf "$ROOTFS/dev" || true
sudo umount -lf "$ROOTFS/proc" || true
sudo umount -lf "$ROOTFS/sys" || true
sudo umount -lf "$ROOTFS/run" || true
