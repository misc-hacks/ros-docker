misc-hacks/ros-docker
=====================

Containerized ROS environments.

## Quick Start for Desktop Images

Here is an example starting script for running desktop images:

```bash
docker run -d \
  --name=ros-desktop \
  -e TZ=Asia/Shanghai \
  -p 3389:3389 \
  --shm-size 1gb \
  --restart unless-stopped \
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
```

Note the default user:password is `abc:abc` and make sure to change the password
the first time you login.
