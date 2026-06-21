#!/bin/bash
set -eux

mkdir -p iso/boot/grub
mkdir -p iso/boot/grub/themes/DuyKhanhOS
mkdir -p iso/boot/grub/fonts
mkdir -p iso/boot/grub/i386-pc
mkdir -p iso/EFI/boot

cp config/grub/grub.cfg iso/boot/grub/

cp -r config/grub/themes/DuyKhanhOS/* \
iso/boot/grub/themes/DuyKhanhOS/

cp /usr/share/grub/unicode.pf2 \
iso/boot/grub/fonts/

# UEFI
grub-mkstandalone \
-O x86_64-efi \
-o iso/EFI/boot/bootx64.efi \
"boot/grub/grub.cfg=iso/boot/grub/grub.cfg"

# BIOS
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
