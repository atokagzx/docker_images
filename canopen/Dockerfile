ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /root/ws_ros_contrib/src
RUN git clone https://github.com/ros-industrial/ros2_canopen.git

WORKDIR /root/ws_ros_contrib

RUN /usr/bin/zsh -c 'source /opt/ros/noetic/setup.zsh && rosdep install --from-paths src/ros2_canopen --ignore-src -r -y && catkin_make' && \
    echo "source /root/ws_ros_contrib/devel/setup.bash" >> ~/.bashrc && \
    echo "source /root/ws_ros_contrib/devel/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
