ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /root/ws_ros_contrib
RUN pip uninstall -y opencv-contrib-python
RUN git clone https://github.com/withrobot/oCam.git /tmp/oCam && \
    mkdir -p /root/ws_ros_contrib/src/ocam && \
    mv /tmp/oCam/Software/oCam_ROS_Package /root/ws_ros_contrib/src/ocam && \
    rm -rf /tmp/oCam

RUN apt update && apt install -y    libudev-dev \
    libv4l-dev \
&& rm -rf /var/lib/apt/lists/*
RUN sed -i 's/find_package(OpenCV 3.2.0 REQUIRED)/find_package(OpenCV REQUIRED)/' \
    /root/ws_ros_contrib/src/ocam/oCam_ROS_Package/ocam/CMakeLists.txt

RUN /usr/bin/zsh -c 'source /opt/ros/noetic/setup.zsh && catkin_make' && \
    echo "source /root/ws_ros_contrib/devel/setup.bash" >> ~/.bashrc && \
    echo "source /root/ws_ros_contrib/devel/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
