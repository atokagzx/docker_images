FROM ubuntu:22.04

# Timezone Configuration
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y    apt-utils \
                                    lsb-release \
                                    gnupg2 \
                                    net-tools \
                                    iputils-ping \
                                    build-essential \
                                    wget \
                                    unzip \
                                    curl \
                                    git \
                                    nano \
                                    ffmpeg \
                                    x11-apps \
                                    xorg-dev \
                                    libglu1-mesa-dev \
                                    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" -- \
    -t bira \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

RUN apt update && apt install -y \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir setuptools==70.0.0 
RUN pip3 install --upgrade pip

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt --no-cache-dir

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && apt install -y ros-noetic-desktop-full
RUN apt update && apt install -y python3-rosdep \
                                python3-rosinstall \
                                python3-rosinstall-generator \
                                python3-wstool \
                                build-essential \
                                ros-noetic-moveit

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/noetic/setup.zsh" >> ~/.zshrc

WORKDIR /root/ws_ros_contrib
# Install ocam_ros
RUN apt update && apt install -y    libudev-dev \
                                    libv4l-dev \
    && rm -rf /var/lib/apt/lists/*
ADD https://github.com/superjax/ocam_ros.git#main /root/ws_ros_contrib/src/ocam_ros
RUN /usr/bin/zsh -c 'source /opt/ros/noetic/setup.zsh && catkin_make'
RUN echo "source /root/ws_ros_contrib/devel/setup.bash" >> ~/.bashrc
RUN echo "source /root/ws_ros_contrib/devel/setup.zsh" >> ~/.zshrc

COPY ./entrypoint.sh /tmp/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/tmp/entrypoint.sh"]
