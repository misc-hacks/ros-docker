FROM danielguerra/ubuntu-xrdp:16.04

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
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
    && echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
       | tee /etc/apt/sources.list.d/ros.list > /dev/null

# Install ROS
ARG PACKAGES="ros-kinetic-desktop-full"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Get ROS dependencies
ARG PACKAGES="python-rosdep python-rosinstall python-rosinstall-generator python-wstool"
RUN apt-get update \
    && apt-get install -y ${PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Initialize ROS
RUN rosdep init \
    && rosdep update
