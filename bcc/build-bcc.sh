#!/bin/bash
# This script should run within a bcc checkout

spath=$( cd "$(dirname "$0")" ; pwd -P )
cd $spath

rm -rf build && mkdir -p build && cd build
git config --global url."https://ghproxy.com/https://github.com".insteadOf "https://github.com"
git config --global url."git://ghproxy.com/git://github.com".insteadOf "git://github.com"
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_C_COMPILER=clang-11 -DCMAKE_CXX_COMPILER=clang++-11
make -j4
make install
cmake -DPYTHON_CMD=python3 ..
pushd src/python/
make
make install
popd
cd ..
rm -rf build
