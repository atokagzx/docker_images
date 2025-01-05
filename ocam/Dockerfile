ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /root/ws_ros_contrib
RUN pip uninstall -y opencv-contrib-python
RUN apt-get update && apt-get install -y \
    libopencv-dev=3.2.0+dfsg-4ubuntu0.1 \
    python3-opencv \
    && apt-get clean

RUN apt update && apt install -y    libudev-dev \
                                    libv4l-dev \
    && rm -rf /var/lib/apt/lists/*
ADD  https://github.com/withrobot/oCam.git#master /tmp/oCam
RUN mkdir -p /root/ws_ros_contrib/src/ocam && \
    mv /tmp/oCam/Software/oCam_ROS_Package /root/ws_ros_contrib/src/ocam && \
    rm -rf /tmp/oCam
RUN /usr/bin/zsh -c 'source /opt/ros/noetic/setup.zsh && catkin_make'

RUN echo "source /root/ws_ros_contrib/devel/setup.bash" >> ~/.bashrc
RUN echo "source /root/ws_ros_contrib/devel/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
