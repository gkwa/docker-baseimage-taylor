# https://github.com/phusion/baseimage-docker#getting_started

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN sudo apt-get -qq update
RUN sudo apt-get -qq install --assume-yes git curl
RUN curl -O https://raw.githubusercontent.com/TaylorMonacelli/emacs-in-containers/wip/init.sh | sh -
RUN curl -O https://raw.githubusercontent.com/TaylorMonacelli/emacs-in-containers/wip/stow.sh | sh -
RUN curl -O https://raw.githubusercontent.com/TaylorMonacelli/emacs-in-containers/wip/emacs.sh | sh -

##############################
# Enable sshd
# https://github.com/phusion/baseimage-docker#enabling_ssh

RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh


# https://github.com/phusion/baseimage-docker#using_your_own_key
## Install an SSH of your choice.
ADD taylors_ssh_key.pub /tmp/your_key.pub
RUN cat /tmp/your_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub

##############################


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
