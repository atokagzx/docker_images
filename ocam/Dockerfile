ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /root/ws_ros_contrib
RUN pip install opencv-contrib-python==3.4.18.65

RUN apt update && apt install -y    libudev-dev \
                                    libv4l-dev \
    && rm -rf /var/lib/apt/lists/*
# ADD  https://github.com/withrobot/oCam.git#master /root/ws_ros_contrib/src/ocam
ADD  https://github.com/withrobot/oCam.git#master /tmp/oCam
RUN mv /tmp/oCam/Software/oCam_ROS_Package /root/ws_ros_contrib/src/ocam && \
    rm -rf /tmp/oCam
RUN /usr/bin/zsh -c 'source /opt/ros/noetic/setup.zsh && catkin_make'
RUN echo "source /root/ws_ros_contrib/devel/setup.bash" >> ~/.bashrc
RUN echo "source /root/ws_ros_contrib/devel/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
