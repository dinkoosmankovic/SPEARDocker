# moveit/moveit:melodic-release
# Full debian-based install of MoveIt using apt-get

FROM ros:melodic-ros-base
MAINTAINER Dinko Osmankovic dinko.osmankovic@etf.unsa.ba

ENV ROS_UNDERLAY /root/ws_moveit/install
WORKDIR $ROS_UNDERLAY/../src


ENV PYTHONIOENCODING UTF-8

# Commands are combined in single RUN statement with "apt/lists" folder removal to reduce image size
RUN apt-get update && \
    apt-get install -y ros-${ROS_DISTRO}-desktop-full && \
    rm -rf /var/lib/apt/lists/*

RUN \
    # Download moveit source so that we can get necessary dependencies
    wstool init . https://raw.githubusercontent.com/ros-planning/moveit/master/moveit.rosinstall && \
    #
    # Update apt package list as cache is cleared in previous container
    # Usually upgrading involves a few packages only (if container builds became out-of-sync)
    apt-get -qq update && \
    apt-get -qq dist-upgrade && \
    #
    rosdep update && \
    rosdep install -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} --as-root=apt:false && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
        build-essential  \
        cmake \
        libboost-filesystem-dev \
        libboost-numpy-dev \
        libboost-program-options-dev \
        libboost-python-dev \
        libboost-serialization-dev \
        libboost-system-dev \
        libboost-test-dev \
        libeigen3-dev \
        libexpat1 \
        libflann-dev \
        libode-dev \
        libtinfo5 \
        libtriangle-dev \
        pkg-config \
        python3-dev \
        python3-numpy \
        python3-pip \
        wget && \
    # Install spot
    cd && \
    mkdir -p ompl && \
    cd ompl && \
    wget https://ompl.kavrakilab.org/install-ompl-ubuntu.sh && \
    chmod u+x install-ompl-ubuntu.sh && \
    ./install-ompl-ubuntu.sh
