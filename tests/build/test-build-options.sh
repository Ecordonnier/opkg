#!/bin/bash

set -ex

TOP_DIR=$(dirname "$0")/../../..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR && make && make run-tests VERBOSE=1 && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DSTATIC_LIBOPKG=1 -DWITH_GPGME=1 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DSTATIC_LIBOPKG=1 -DWITH_BZIP2=1 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DSTATIC_LIBOPKG=1 -DWITH_LZ4=1 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DSTATIC_LIBOPKG=1 -DWITH_LZSTD=1 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DSTATIC_LIBOPKG=1 -DUSE_SOLVER_LIBSOLV=0 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DWITH_XZ=0 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DENABLE_XATTR=0 && make && cd ..
rm -rf build && mkdir build && cd build && cmake $TOP_DIR -DWITH_LIBOPKG_API=1 -DUSE_SOLVER_LIBSOLV=0 && make && cd ..
rm -rf build
