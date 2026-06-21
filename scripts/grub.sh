#!/bin/bash
set -eux

mkdir -p iso/boot/grub
mkdir -p iso/EFI/boot

cp config/grub/grub.cfg iso/boot/grub/

grub-mkstandalone \
    -O x86_64-efi \
    -o iso/EFI/boot/bootx64.efi \
    "boot/grub/grub.cfg=iso/boot/grub/grub.cfg"

grub-mkstandalone \
    -O i386-pc \
    -o iso/boot/grub/core.img \
    "boot/grub/grub.cfg=iso/boot/grub/grub.cfg"
