# https://github.com/phusion/baseimage-docker#getting_started

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.16

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN sudo apt-get -qq update
RUN sudo apt-get -qq install --assume-yes git curl emacs
RUN curl https://raw.githubusercontent.com/TaylorMonacelli/ubuntu_taylor/master/setup.sh | sh -

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
