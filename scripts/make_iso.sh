#!/bin/bash

mkdir -p output

xorriso -as mkisofs \
-r \
-V DuyKhanhOS \
-o output/DuyKhanhOS-5.0-final-amd64.iso \
-J \
-joliet-long \
-l \
-iso-level 3 \
-eltorito-alt-boot \
-e EFI/boot/bootx64.efi \
-no-emul-boot \
iso
