FROM ubuntu:22.04

# Timezone Configuration
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

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

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t bira \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

RUN apt update && apt install -y \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt --no-cache-dir
