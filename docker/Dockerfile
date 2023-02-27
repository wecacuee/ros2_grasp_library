########################################################
# Based on Ubuntu 20.04
########################################################

# Set the base image to ubuntu 20.04

FROM ubuntu:focal

MAINTAINER Liu Cong "congx.liu@intel.com"

ARG DEPS_DIR=/root/deps
WORKDIR $DEPS_DIR

# install ros2 grasp library deps
COPY ./script/ $DEPS_DIR/script/
RUN bash script/install_ros2_grasp_library.sh /root/deps

WORKDIR /root
ENTRYPOINT ["/root/script/ros_entrypoint.sh"]
CMD ["bash"]
