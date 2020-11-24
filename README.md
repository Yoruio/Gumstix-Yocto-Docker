# Gumstix-Yocto-Docker
Docker image to build gumstix Yocto images

## Building Docker image
After cloning Repository, build image with
```sh
$ docker build --no-cache --tag "yocto-build-env:latest" .
```
## Making changes to Yocto
Start container and enter to make changes:
```sh
$ docker run --entrypoint /bin/bash -it -v [path to output directory on host]:/home/yocto/build/tmp/deploy/images yocto-build-env:latest --name "gumstix_docker_image"
```
## Building Yocto image
#### To start container and build Yocto with default settings:
```sh
$ docker run --rm -ti -v $PWD/output:/home/yocto/build/tmp/deploy/images yocto-build-env:latest
```
#### To build container after making changes in the *[Making changes to Yocto](Making-changes-to-Yocto-) section:

Start and attach to Docker container if not already inside:
```sh
$ docker start gumstix_docker_image
$ docker attach gumstix_docker_image
```

Build image from within docker container:
```sh
$ cd /home/yocto
$ source source poky/oe-init-build-env build && bitbake [image name]
```
