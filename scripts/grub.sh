#!/bin/bash
set -eux

mkdir -p iso/boot/grub
mkdir -p iso/boot/grub/themes/DuyKhanhOS
mkdir -p iso/boot/grub/fonts

cp config/grub/grub.cfg iso/boot/grub/grub.cfg

cp -r config/grub/themes/DuyKhanhOS/* \
      iso/boot/grub/themes/DuyKhanhOS/

cp /usr/share/grub/unicode.pf2 \
      iso/boot/grub/fonts/
