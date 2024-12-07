ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu \
    $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update && apt install -y cargo \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup update stable && cargo install urdf-viz


RUN apt update && apt install -y ros-dev-tools \
    ros-humble-desktop \
    ros-humble-joint-state-publisher \
    ros-humble-joint-trajectory-controller \
    ros-humble-hardware-interface \
    ros-humble-controller-manager \
    ros-humble-ros2-control \
    ros-humble-control-toolbox \
    ros-humble-joint-state-publisher-gui  \
    ros-humble-dynamixel-sdk \
    ros-humble-ros2-controllers \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros2-control \
    ros-humble-ros-testing \
    ros-humble-ament-cmake-google-benchmark \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'eval "$(register-python-argcomplete3 ros2)"\neval "$(register-python-argcomplete3 colcon)"' >> ~/.zshrc

WORKDIR /osqp
RUN git clone https://github.com/osqp/osqp && \
    cd osqp && \
    mkdir build && cd build && \
    cmake -G "Unix Makefiles" .. && \
    cmake --build . --target install

ADD https://github.com/moveit/moveit2.git#main /root/ws_moveit2/src/moveit2
WORKDIR /root/ws_moveit2

RUN /usr/bin/zsh -c 'source /opt/ros/humble/setup.zsh && \
    apt update && \
    rosdep init && rosdep update && \
    for repo in src/moveit2/moveit2.repos $(f="src/moveit2/moveit2_humble.repos"; test -r $f && echo $f); do vcs import < "$repo"; done && \
    rosdep install -r --from-paths . --ignore-src --rosdistro humble -y && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    rm -rf /var/lib/apt/lists/*'

RUN echo "source /opt/ros/humble/setup.bash\nsource /root/ws_moveit2/install/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/humble/setup.zsh\nsource /root/ws_moveit2/install/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
