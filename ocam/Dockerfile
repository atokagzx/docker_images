ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /root/ws_ros_contrib
RUN pip install opencv-contrib-python==3.4.18.65

RUN apt update && apt install -y    libudev-dev \
                                    libv4l-dev \
    && rm -rf /var/lib/apt/lists/*
# ADD --exclude= https://github.com/withrobot/oCam.git#master /root/ws_ros_contrib/src/ocam
RUN git clone --depth 1 --filter=blob:none --sparse https://github.com/withrobot/oCam.git /tmp/oCam && \
    cd /tmp/oCam && \
    git sparse-checkout init --cone && \
    git sparse-checkout set Software/oCam_ROS_Package && \
    mv Software/oCam_ROS_Package /root/ws_ros_contrib/src/ocam && \
    rm -rf /tmp/oCam
RUN /usr/bin/zsh -c 'source /opt/ros/noetic/setup.zsh && catkin_make'
RUN echo "source /root/ws_ros_contrib/devel/setup.bash" >> ~/.bashrc
RUN echo "source /root/ws_ros_contrib/devel/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
