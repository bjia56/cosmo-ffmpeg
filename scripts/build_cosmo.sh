#!/bin/bash

PLATFORM=cosmo
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source ${SCRIPT_DIR}/utils.sh

########################
# Install dependencies #
########################
echo "::group::Install dependencies"

export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt -y install \
  wget pkg-config autoconf git patch \
  gettext bison libtool autopoint gperf ncurses-bin xutils-dev

export AR=$(command -v cosmoar)
export CC=cosmocc
export CXX=cosmoc++
export CFLAGS="-I${DEPSDIR}/include"
export CPPFLAGS="-I${DEPSDIR}/include"
export CXXFLAGS="${CPPFLAGS} -fexceptions"
export LDFLAGS="-L${DEPSDIR}/lib"
export PKG_CONFIG_PATH="${DEPSDIR}/lib/pkgconfig:${DEPSDIR}/share/pkgconfig"

mkdir -p ${DEPSDIR}/lib/.aarch64

echo "::endgroup::"