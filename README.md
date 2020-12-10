# Gumstix-Yocto-Docker
Docker image to build gumstix Yocto images

## Building Docker image
After cloning repository, build image with
```sh
$ docker build --no-cache --tag "yocto-build-env:latest" .
```
## Making changes to Yocto
Start and enter Docker container to make changes:
```sh
$ docker run --entrypoint /bin/bash -it -v [path to output directory on host]:/home/yocto/build/tmp/deploy/images yocto-build-env:latest --name "gumstix_docker_image"
```
## Building Yocto image
#### Start container and build Yocto with default settings:
*If you made changes to Yocto, skip this.*
You can replace *$PWD/output* with any directory on host system that you own.
```sh
$ docker run --rm -t -v $PWD/output:/yocto/build/tmp/deploy/images -e MACHINE=[machine name] -e IMAGE=[image name] -e UID=$(id -u) -e GID=$(id -g) yocto-build-env:latest
```
for example, building gumstix-lxqt-image for raspberrypi4-64, and outputting to the ~/gumstix-image/ directory:
```sh
$ docker run --rm -t -v ~/gumstix-image:/yocto/build/tmp/deploy/images -e MACHINE=raspberrypi4-64 -e IMAGE=gumstix-lxqt-image -e UID=$(id -u) -e GID=$(id -g) yocto-build-env:latest
```

#### Build container after making changes in the *[Making changes to Yocto](Making-changes-to-Yocto-) section:
*If you built yocto with default settings, skip this.*

Start and attach to Docker container if not already inside:
```sh
$ docker start gumstix_docker_image
$ docker attach gumstix_docker_image
```

Build image from within docker container:
```sh
$ cd /yocto
$ source poky/oe-init-build-env build && bitbake [image name]
```
