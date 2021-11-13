FROM lscr.io/linuxserver/rdesktop:mate-focal

# Get common dependencies
ARG PACKAGES="curl gnupg2 lsb-release"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Add apt source for ROS
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" \
       | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Get ROS package
ARG ROS_VERSION="foxy-20211013"
ARG ROS_PACKAGE="ros2-${ROS_VERSION}-linux-focal-amd64.tar.bz2"
RUN mkdir /workspace \
    && curl -L https://github.com/ros2/ros2/releases/download/release-${ROS_VERSION}/${ROS_PACKAGE} -o /workspace/${ROS_PACKAGE} \
    && mkdir /workspace/ros2_foxy \
    && tar xf /workspace/${ROS_PACKAGE} -C /workspace/ros2_foxy \
    && rm /workspace/${ROS_PACKAGE}

# Get ROS dependencies
ARG PACKAGES="python3-rosdep libpython3-dev python3-pip"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Initialize ROS
RUN rosdep init \
    && rosdep update \
    && apt-get update \
    && rosdep install \
        --from-paths /workspace/ros2_foxy/ros2-linux/share --ignore-src -y --skip-keys \
        "cyclonedds fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers" \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install -U argcomplete

# Post-initialization
RUN chown abc:abc -R /workspace
