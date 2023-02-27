#!/bin/bash

DEPS_DIR=${DEPS_PATH}
SUDO=$1
if [ "$SUDO" == "sudo" ];then
        SUDO="sudo"
else
        SUDO=""
fi

# install gpd
cd $DEPS_DIR
git clone --depth 1 https://github.com/wecacuee/gpd.git
cd gpd
mkdir -p build && cd build
cmake -DUSE_OPENVINO=On .. && make
$SUDO make install
