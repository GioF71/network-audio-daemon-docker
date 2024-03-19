#!/bin/bash

# https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_5.0.0-59_armhf.deb
# https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_5.0.0-59_arm64.deb
# https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_5.0.0-59_amd64.deb
DOWNLOAD_PREFIX=https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_

ARCH=`uname -m`
echo "ARCH=[${ARCH}] FORCE_ARCH=[${FORCE_ARCH}]"
if [[ -n "${FORCE_ARCH}" ]]; then
    echo "Overriding ARCH=[${ARCH}] to [${FORCE_ARCH}]"
    ARCH="${FORCE_ARCH}"
fi

arch_amd64=x86_64
arch_arm_v7=armv7l
arch_arm_v8=aarch64

declare -A naming
naming[$arch_amd64]=amd64
naming[$arch_arm_v7]=armhf
naming[$arch_arm_v8]=arm64

DL_BINARY_TYPE=${naming["${ARCH}"]};
echo "DL_BINARY_TYPE=[${DL_BINARY_TYPE}]"

echo "NAA_VERSION=[${NAA_VERSION}]"

DOWNLOAD_URL="${DOWNLOAD_PREFIX}${NAA_VERSION}_$DL_BINARY_TYPE.deb"
echo "DOWNLOAD_URL=[${DOWNLOAD_URL}]"

mkdir -p /app/release
cd /app/release
wget $DOWNLOAD_URL -O naa.deb
