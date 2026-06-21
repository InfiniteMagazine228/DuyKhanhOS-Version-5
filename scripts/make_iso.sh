#!/bin/bash
set -eux

mkdir -p output

xorriso -as mkisofs \
-r \
-V "DuyKhanhOS" \
-o output/DuyKhanhOS-5.0-final-amd64.iso \
-J \
-joliet-long \
-l \
-iso-level 3 \
-b boot/grub/bios.img \
-no-emul-boot \
-boot-load-size 4 \
-boot-info-table \
-eltorito-alt-boot \
-e EFI/boot/bootx64.efi \
-no-emul-boot \
iso
