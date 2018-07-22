#!/bin/bash

if [ -z "$1" ]; then
    echo "No version specified"
fi

DIR_ARCHS=(amd64 i386 armhf aarch64)

for index in ${!DIR_ARCHS[*]}; do
    sed -i -e "s/^ENV VERSION .*$/ENV VERSION $1/g" ${DIR_ARCHS[$index]}/Dockerfile
done
