#!/bin/bash

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

function verify_checksum () {
  file="$1"
  filename=$(basename $file)
  echo "$(cat ${SCRIPT_DIR}/../checksums/$file.sha256)" | sha256sum -c
}

function download_and_verify () {
  file="$1"
  curl -s -S -f -L -o $file https://github.com/bjia56/build-dependencies/releases/download/cosmo-ffmpeg/$file
  verify_checksum $file
}

function download_verify_extract () {
  #set -x
  file="$1"
  download_and_verify $file
  tar -xf $file
  rm $file
  #set +x
}

WORKDIR=$(pwd)
BUILDDIR=${WORKDIR}/build
DEPSDIR=${WORKDIR}/deps

if [[ "${DEBUG_CI}" == "true" ]]; then
  trap "cd ${BUILDDIR} && tar -czf ${WORKDIR}/build-ffmpeg.tar.gz ." EXIT
fi

mkdir ${BUILDDIR}
mkdir ${DEPSDIR}
