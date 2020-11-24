FROM ubuntu:16.04

# Install necessary packages
RUN apt-get update && apt-get -y install software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa 
RUN apt-get update && apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat libsdl1.2-dev xterm python python3.7 tar locales cpio git libncurses5-dev \
    pkg-config subversion texi2html texinfo curl

RUN rm /usr/bin/python
RUN ln -s /usr/bin/python3.7 /usr/bin/python

RUN python --version

# Set default shell to BASH for source
RUN rm /bin/sh && ln -s bash /bin/sh

# Set locale
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

#ARG host_uid=1001
#ARG host_gid=1001
#RUN groupadd -g $host_gid gumstix && useradd -g $host_gid -m -s /bin/bash -u $host_uid gumstix 

ENV BUILD_INPUT_DIR /home/yocto

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > repo
RUN chmod a+x repo
RUN mv repo /usr/local/bin

#USER gumstix

RUN mkdir -p $BUILD_INPUT_DIR
WORKDIR $BUILD_INPUT_DIR

RUN repo init -u git://github.com/gumstix/yocto-manifest.git -b morty
RUN repo sync
# Disable sanity check to allow building as root
RUN sed -i 's/INHERIT += "sanity"/#INHERIT += "sanity"/g' poky/meta/conf/sanity.conf

RUN rm /usr/bin/python
RUN ln -s /usr/bin/python2 /usr/bin/python
#USER gumstix

ENV TEMPLATECONF=meta-gumstix-extras/conf

ENTRYPOINT source poky/oe-init-build-env build && bitbake gumstix-console-image

#USER gumstix
