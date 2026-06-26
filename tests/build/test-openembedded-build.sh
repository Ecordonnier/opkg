#!/bin/bash

# This script uses the development docker container to build and validate the
# project according to the defaults present in the OpenEmbedded-core meta layer.
# https://git.openembedded.org/openembedded-core/tree/meta/recipes-devtools/opkg

set -e

SCRIPT_ROOT=$(realpath "$(dirname "$0")")
PROJECT_ROOT=$(realpath "${SCRIPT_ROOT}/../..")

image_id=$(docker build "${PROJECT_ROOT}/docker" -q)
echo "Using docker image: ${image_id}"

container_id=$(docker run -d \
	-v "${PROJECT_ROOT}":/usr/local/src/opkg/:rw \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/group:/etc/group:ro \
	-u $(id -u):$(id -g) \
	"${image_id}" tail -f /dev/null)
echo "Using docker container: ${container_id}"

docker exec -i "${container_id}" bash <<EOF
	cd /usr/local/src/opkg
	rm -rf ./build-oe
	mkdir ./build-oe
	cd ./build-oe
	cmake \
		-DUSE_SOLVER_LIBSOLV=ON \
		-DWITH_ACL=ON \
		-DUSE_XATTR=ON \
		..
	make
	make check
EOF
