misc-hacks/ros-docker
=====================

Containerized ROS environments.

## Quick Start for Desktop Images (18.04 and 20.04)

Here is an example starting script for running desktop images (applicable to
`melodic` and `foxy`):

```bash
docker run -d \
  --name ros-desktop \
  --restart unless-stopped \
  --shm-size 1gb \
  -p 3389:3389 \
  ghcr.io/misc-hacks/ros:{the-version-you-want}

# Optional settings

# id and group for user abc
# -e PUID=$(id -u)
# -e PGID=$(id -g)

# home volume
# -v /path/to/data:/config

# workspace (please take care of the privilege problem)
# -v /path/to/ws:/workspace

# docker (the image has a docker client included)
# -v /var/run/docker.sock:/var/run/docker.sock

# usually mapping usb ports is desired
# --privileged -v /dev/bus/usb:/dev/bus/usb
```

Note the default user:password is `abc:abc` and make sure to change the password
the first time you login.

## Quick Start for Desktop Images (16.04)

Here is an example starting script for running desktop images (applicable to
`kinetic`):

```bash
docker run -d \
  --name ros-desktop \
  --restart unless-stopped \
  --shm-size 1g \
  -p 3389:3389 \
  ghcr.io/misc-hacks/ros:{the-version-you-want}

# Optional settings

# ssh service
# -p 2222:22

# workspace (please take care of the privilege problem)
# -v /path/to/ws:/workspace

# usually mapping usb ports is desired
# --privileged -v /dev/bus/usb:/dev/bus/usb
```

Note the default user:password is `ubuntu:ubuntu` and make sure to change the
password the first time you login.

## General Tips for Desktop Images

Containers running remote desktop services may suffer from poor video
performance. To help a bit, you are suggested to disable display compositing:
- Goto
    - Applications (at the top-left corner of the desktop)
    - Settings (menu)
    - Window Manager Tweaks (sub-menu)
    - Compositor (tab)
- Uncheck "Enable display compositing"
