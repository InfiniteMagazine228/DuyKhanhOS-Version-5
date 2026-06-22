#!/bin/bash
set -eux

ROOTFS=rootfs

mkdir -p \
"$ROOTFS/home/live/Desktop"

cp overlay/home/live/Desktop/Install\ DuyKhanhOS.desktop \
"$ROOTFS/home/live/Desktop/"

chmod +x \
"$ROOTFS/home/live/Desktop/Install DuyKhanhOS.desktop"

chown -R 1000:1000 \
"$ROOTFS/home/live"
