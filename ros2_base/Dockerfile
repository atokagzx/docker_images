ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu \
$(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update && apt upgrade -y && \
    apt install -y ros-dev-tools \
    ros-humble-ros-base \
    ros-humble-joy \
    && rm -rf /var/lib/apt/lists/*
    
RUN echo 'eval "$(register-python-argcomplete3 ros2)"\neval "$(register-python-argcomplete3 colcon)"' >> ~/.zshrc

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt --no-cache-dir

ADD https://github.com/naoki-mizuno/ds4_driver#humble-devel /opt/contrib_ws/src
WORKDIR /opt/contrib_ws
RUN /bin/zsh -c "source /opt/ros/humble/setup.zsh && colcon build"
RUN echo "source /opt/ros/humble/setup.bash\nsource /opt/contrib_ws/install/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/humble/setup.zsh\nsource /opt/contrib_ws/install/setup.zsh" >> ~/.zshrc

COPY entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
