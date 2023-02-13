#!/bin/bash
ROS_DISTRO=foxy
SUDO=$1
if [ "$SUDO" == "sudo" ];then
        SUDO="sudo"
else
        SUDO=""
fi

$SUDO apt-get install -y ros-$ROS_DISTRO-object-msgs \
        python3-scipy \
        ros-$ROS_DISTRO-eigen3-cmake-module

WORK_DIR=${DEPS_PATH}/../ros2_ws
mkdir -p $WORK_DIR/src &&cd $WORK_DIR/src

git clone --depth 1 https://github.com/RoboticsYY/ros2_ur_description.git
git clone --depth 1 https://github.com/RoboticsYY/handeye
git clone --depth 1 https://github.com/RoboticsYY/criutils.git
git clone --depth 1 https://github.com/RoboticsYY/baldor.git
git clone --depth 1 https://github.com/intel/ros2_intel_realsense.git -b refactor
git clone --depth 1 https://github.com/wecacuee/ros2_grasp_library.git

cd $WORK_DIR
source /opt/ros/$ROS_DISTRO/setup.sh
export InferenceEngine_DIR=/opt/openvino_toolkit/openvino/build/
export CPU_EXTENSION_LIB=/opt/openvino_toolkit/openvino/bin/intel64/Release/lib/libopenvino_template_extension.so
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$InferenceEngine_DIR/../bin/intel64/Release/lib

colcon build --symlink-install
