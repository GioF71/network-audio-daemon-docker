# network-audio-daemon-docker

A docker image for network-audio-adapter by [signalyst](https://www.signalyst.com/index.html).  

## References

NAME|LINK
:---|:---
Main website|[Website](https://www.signalyst.com/)
Consumer Products|[Link](https://www.signalyst.com/consumer.html)

## Links

REPOSITORY TYPE|LINK
:---|:---
Git Repository|[GitHub](https://github.com/GioF71/network-audio-daemon-docker.git)
Docker Images|[Docker Hub](https://hub.docker.com/repository/docker/giof71/network-audio-daemon)

## Build

### Build Arguments

ARGUMENT|DESCRIPTION
:---|:---
NAA_VERSION|The version to install, defaults to `5.0.0-59`
FORCE_ARCH|Force the installation of the specified architecture, empty by default

### Build Examples

You can build version e.g. 5.0.0-59 (the current default) using the following command:

```sh
docker build . --build-arg -t giof71/network-audio-daemon
```

If you need to force the architecture (for example on a Raspberry Pi 4 running OSMC, so arm64 architecture but armhf packages), run the following:

```sh
docker build . --build-arg FORCE_ARCH=armv7l -t giof71/network-audio-daemon
```

## Configure

### Environment Variables

VARIABLE|DESCRIPTION
:---|:---
NAA_NAME|Player name, defaults to an empty string

## Usage

### Using docker run

You can run the container by typing:

```sh
docker run -d --name network-audio-daemon --network=host --device /dev/snd -e NAA_NAME=D10 giof71/network-audio-daemon
```

It is possible to run the container using a specific uid:gid:

```sh
docker run -d --name network-audio-daemon --user "1000:29" --network=host --device /dev/snd -e NAA_NAME=D10 giof71/network-audio-daemon
```

I am using uid 1000 and gid 29 which corresponds, on my system, to the `audio` group.  
Check the gid of the group `audio` using this command:

`getent group audio`

### Using docker compose

Example compose file:

```text
---
version: "3"

services:
  network-audio-daemon:
    image: giof71/network-audio-daemon:latest
    container_name: network-audio-daemon
    user: "1000:29"
    network_mode: host
    devices:
      - /dev/snd:/dev/snd
    environment:
      - NAA_NAME=D10
    restart: unless-stopped
```

The `user` clause is optional as described in the [Using docker run](#using-docker-run) paragraph.
