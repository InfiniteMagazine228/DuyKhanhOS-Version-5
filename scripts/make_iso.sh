#!/bin/bash
set -eux

mkdir -p output

grub-mkrescue \
    -o output/DuyKhanhOS-5.0-final-amd64.iso \
    iso
