#!/bin/bash
set -eux

mkdir -p output

xorriso -as mkisofs \
-r \
-J \
-joliet-long \
-l \
-iso-level 3 \
-V "DuyKhanhOS" \
-o output/DuyKhanhOS-5.0-final-amd64.iso \
-eltorito-alt-boot \
-e EFI/boot/bootx64.efi \
-no-emul-boot \
iso
