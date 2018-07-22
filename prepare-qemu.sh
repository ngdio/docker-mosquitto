#!/bin/bash

# Building armhf and aarch64 images from amd64 requires QEMU.
# It must be downloaded in advance and then be added to the
# respective Docker containers before anything can be executed.

QEMU_VERSION=2.12.0

for arch in i386 arm aarch64; do
    wget https://github.com/multiarch/qemu-user-static/releases/download/v$QEMU_VERSION/x86_64_qemu-aarch64-static.tar.gz \
        -O qemu-$arch.tar.gz
done
