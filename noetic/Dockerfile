from osrf/ros:noetic-desktop-full

SHELL [ "/bin/bash", "-c" ]

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 42D5A192B819C5DA

RUN apt-get update && apt-get install -y \
  net-tools \
  git \
  vim \
  libeigen3-dev \
  python3-pip \
  python3-catkin-tools \
  ros-noetic-pcl-conversions \
  && rm -rf /var/lib/apt/list/* \
  && apt clean

