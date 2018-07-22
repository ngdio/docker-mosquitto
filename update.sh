#!/bin/bash

DIR_ARCHS=(amd64 i386 armhf aarch64)
IMAGE_ARCHS=(amd64 i386 arm32v6 arm64v8)

for index in ${!DIR_ARCHS[*]}; do
    sed -e "s/%%ARCH%%/${IMAGE_ARCHS[$index]}/g" Dockerfile > ${DIR_ARCHS[$index]}/Dockerfile
done
