#!/bin/bash

ROS_IP="$1"
if [ -z "$1" ]; then
  echo "use localhost network. (If you need specific IP, plz provide it as an argument.)"
  ROS_IP="localhost"
fi

xhost +local:root

XAUTH=/tmp/.docker.xauth

if [ ! -f $XAUTH ]; then
  xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
  if [ ! -z "$xauth_list" ]; then
    echo $xauth_list | xauth -f $XAUTH nmerge -
  else
    touch $XAUTH
  fi
  chmod a+r $XAUTH
fi

sudo docker run -it --rm \
  --privileged \
  --net host \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -e ROS_MASTER_URI=http://$ROS_IP:11311 \
  -e ROS_HOSTNAME=$ROS_IP \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v ./home:/home:rw \
  --device /dev/ttyUSB0:/dev/ttyUSB0 \
  port_noetic bash
