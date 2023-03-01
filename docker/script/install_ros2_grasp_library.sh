#!/bin/bash

set -e

deps_path=$1
if [ -z "$deps_path" ]; then
  echo -e "warring:\n    install_ros2_grasp_library_deps.sh <your-install-deps-path>"
  echo -e "If you want to use'sudo' : install_ros2_grasp_library_deps.sh <your-install-deps-path> sudo"
  exit 0
fi

shift

SUDO=$1
if [ "$SUDO" == "sudo" ];then
	SUDO="sudo"
else
	SUDO=""
fi

# mkdir deps-path
echo "DEPS_PATH = $deps_path"
mkdir -p $deps_path
export DEPS_PATH=$deps_path

CURRENT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
echo "CURRENT_DIR = ${CURRENT_DIR}"

# install ros2 dashing
bash ${CURRENT_DIR}/00_ros2_install.sh $@
#  
#  # instal eigen 3.2
#  bash ${CURRENT_DIR}/10_eigen_install.sh $@
$SUDO apt-get update && $SUDO apt-get install -y libeigen3-dev

#  # install libpcl 1.8.1
#  bash ${CURRENT_DIR}/11_libpcl_install.sh $@
$SUDO apt-get update && $SUDO apt-get install -y libpcl-dev

#  
#  # install opencv 4.1.2 
#  bash ${CURRENT_DIR}/12_opencv_install.sh $@
$SUDO apt-get update && $SUDO apt-get install -y libopencv-dev

# install openvino 2019_R3.1
bash ${CURRENT_DIR}/13_openvino_install.sh $@

# install librealsense 2.31
# bash ${CURRENT_DIR}/20_librealsense_install.sh $@
$SUDO apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
$SUDO add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
$SUDO apt-get update && $SUDO apt-get install -y librealsense2-dkms \
      librealsense2-utils librealsense2-dev

# install gpg
bash ${CURRENT_DIR}/30_gpg_install.sh $@

# install gpd
bash ${CURRENT_DIR}/31_gpd_install.sh $@

# install ur_modern_driver
bash ${CURRENT_DIR}/32_ur_modern_driver_install.sh $@

# build ros2 other deps
bash ${CURRENT_DIR}/50_ros2_deps.sh $@
