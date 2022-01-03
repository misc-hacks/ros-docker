FROM lscr.io/linuxserver/rdesktop:mate-bionic

# Get common dependencies
ARG PACKAGES="curl gnupg2 lsb-release build-essential"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Add apt source for ROS
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
       | tee /etc/apt/sources.list.d/ros.list > /dev/null

# Install ROS
ARG PACKAGES="ros-melodic-desktop-full"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Link to setup script
RUN mkdir /workspace \
    && ln -s /opt/ros/melodic/setup.bash /workspace/setup.bash

# Get ROS dependencies
ARG PACKAGES="python-rosdep python-rosinstall python-rosinstall-generator python-wstool"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Initialize ROS
RUN rosdep init \
    && rosdep update

# Post-initialization
RUN chown abc:abc -R /workspace

LABEL maintainer="misc-hacks"
LABEL build_version="none"

LABEL org.opencontainers.image.authors="misc-hacks"
LABEL org.opencontainers.image.created="none"
LABEL org.opencontainers.image.description="Containerized ROS environments."
LABEL org.opencontainers.image.documentation="https://github.com/misc-hacks/ros-docker"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.ref.name="none"
LABEL org.opencontainers.image.revision="none"
LABEL org.opencontainers.image.source="https://github.com/misc-hacks/ros-docker"
LABEL org.opencontainers.image.title="ros"
LABEL org.opencontainers.image.url="https://github.com/misc-hacks/ros-docker/packages"
LABEL org.opencontainers.image.vendor="none"
LABEL org.opencontainers.image.version="none"
