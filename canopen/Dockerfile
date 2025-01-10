ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ADD https://github.com/ros-industrial/ros2_canopen.git#humble /root/ws_ros_contrib/src/ros2_canopen

WORKDIR /root/ws_ros_contrib
RUN /usr/bin/zsh -c 'source /opt/ros/humble/setup.zsh && \
    apt update && \
    rosdep install --from-paths src/ros2_canopen --ignore-src -r -y && \
    colcon build' && \
    echo "source /root/ws_ros_contrib/install/setup.bash" >> ~/.bashrc && \
    echo "source /root/ws_ros_contrib/install/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
