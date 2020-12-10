# Gumstix-Yocto-Docker
This is a Docker image to build gumstix Yocto images in a controlled Linux environment. This image is based on Ubuntu 18.04, using the repo manifest found at https://github.com/Yoruio/yocto-manifest/tree/Yoruio-layers. Current image builds the Dunfell branch of Gumstix images.

## Dockerhub
To build a Yocto image:
```sh
$ docker run --rm -t -v [host output directory]:/yocto/build/tmp/deploy/images -v [host downloads directory]:/yocto/build/downloads -e IMAGE="[image name]" -e MACHINE="[machine name]" -e UID=$(id -u) -e GID=$(id -g) roydu/gumstix-yocto-builder:latest
```
**[host output directory]:** The directory on the host machine where images will be sent to after the build is completed.

**[host downloads directory]:** A directory on the host machine where downloaded sources will be saved. This is optional if you don't want to reuse sources between builds.

**[machine name]:** Machine that the image will be installed on, i.e. *raspberrypi4-64* or *overo* (default raspberrypi4-64)

**[image name]:** Image(s) that yocto will build, separated by spaces. i.e. *gumstix-console-image packagegroup-gumstix*  (default gumstix-console-image)

## Manually building from Dockerfile
### Building Docker image
After cloning repository, build image with
```sh
$ docker build --no-cache --tag "yocto-build-env:latest" .
```
<!---
### Making changes to Yocto
Start and enter Docker container to make changes:
```sh
$ docker run --entrypoint /bin/bash -it -v [host output directory]:/home/yocto/build/tmp/deploy/images -v [host downloads directory]:/yocto/build/downloads yocto-build-env:latest --name "gumstix_docker_image"
```
--->
### Building Yocto image
#### Start container and build Yocto with default settings:
<!--*If you made changes to Yocto, skip this.*-->
```sh
$ docker run --rm -t \
  -v [host output directory]/output:/yocto/build/tmp/deploy/images \
  -v [host downloads directory]:/yocto/build/downloads \
  -e MACHINE=[machine name] \
  -e IMAGE=[image name] \
  -e UID=$(id -u) -e GID=$(id -g) \
  yocto-build-env:latest
```
**[host output directory]:** The directory on the host machine where images will be sent to after the build is completed.

**[host downloads directory]:** A directory on the host machine where downloaded sources will be saved. This is optional if you don't want to reuse sources between builds.

**[machine name]:** Machine that the image will be installed on, i.e. *raspberrypi4-64* or *overo* (default raspberrypi4-64)

**[image name]:** Image(s) that yocto will build, separated by spaces. i.e. *gumstix-console-image packagegroup-gumstix*  (default gumstix-console-image)

for example, building gumstix-lxqt-image for raspberrypi4-64, outputting to the ~/gumstix-image/ directory, and without persistent downloads:
```sh
$ docker run --rm -t \
  -v ~/gumstix-image:/yocto/build/tmp/deploy/images \
  -e MACHINE=raspberrypi4-64 \
  -e IMAGE=gumstix-lxqt-image \
  -e UID=$(id -u) -e GID=$(id -g) \
  yocto-build-env:latest
```

<!---
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
--->
