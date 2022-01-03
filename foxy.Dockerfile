FROM lscr.io/linuxserver/rdesktop:latest

# Get common dependencies
ARG PACKAGES="build-essential curl gnupg2 locales lsb-release"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Change locale settings
RUN locale-gen en_US en_US.UTF-8 \
    && echo "\n\
export LANG=en_US.UTF-8\n\
export LANGUAGE=en_US:en\n\
export LC_ALL=en_US.UTF-8\n\
" | tee /etc/profile.d/locales.sh > /dev/null

# Add apt source for ROS
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" \
       | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS
ARG PACKAGES="ros-foxy-desktop"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Span the workspace directory
RUN mkdir /workspace

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
