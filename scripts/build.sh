#!/bin/bash

set -e

mkdir -p build rootfs iso

sudo debootstrap \
--arch=amd64 \
bookworm \
rootfs \
http://deb.debian.org/debian

echo "Installing packages..."

sudo chroot rootfs apt update

while read p; do
sudo chroot rootfs apt install -y "$p"
done < packages/core.list

while read p; do
sudo chroot rootfs apt install -y "$p"
done < packages/dev.list

while read p; do
sudo chroot rootfs apt install -y "$p"
done < packages/extra.list

echo "Done."
