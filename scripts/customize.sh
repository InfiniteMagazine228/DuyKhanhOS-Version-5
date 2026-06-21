#!/bin/bash

set -e

ROOTFS=rootfs

echo "Creating live user..."

sudo chroot $ROOTFS useradd -m -s /bin/bash live

echo "live:live" | sudo chroot $ROOTFS chpasswd

sudo chroot $ROOTFS usermod -aG sudo live

sudo mkdir -p $ROOTFS/home/live

sudo chown 1000:1000 $ROOTFS/home/live
