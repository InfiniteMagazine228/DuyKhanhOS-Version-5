#!/bin/bash
set -eux

mkdir -p output

# Create hybrid ISO (BIOS + UEFI)
grub-mkrescue \
  -o output/DuyKhanhOS-5.0-final-amd64.iso \
  iso

ls -lah output
