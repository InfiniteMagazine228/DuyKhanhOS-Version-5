#!/bin/bash
set -eux

mkdir -p iso/boot/grub
mkdir -p iso/boot/grub/i386-pc
mkdir -p iso/EFI/boot

cp config/grub/grub.cfg iso/boot/grub/

# ===== UEFI =====

grub-mkstandalone \
  -O x86_64-efi \
  -o iso/EFI/boot/bootx64.efi \
  "boot/grub/grub.cfg=iso/boot/grub/grub.cfg"

# ===== Legacy BIOS =====

grub-mkimage \
  -O i386-pc \
  -o iso/boot/grub/core.img \
  -p /boot/grub \
  biosdisk iso9660 normal linux configfile \
  search part_gpt part_msdos ext2 fat

cat \
/usr/lib/grub/i386-pc/cdboot.img \
iso/boot/grub/core.img \
> iso/boot/grub/bios.img
