FROM debian:buster AS molecule-image

LABEL maintainer="Ivan Medaev"

ENV PIP_PACKAGES="ansible"

COPY jenkins /etc/sudoers.d/jenkins

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
    apt-utils \
    build-essential \
    locales \
    python3-dev \
    python3-pip \
    systemd \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir $PIP_PACKAGES \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /tmp/* /var/tmp/* \
    && locale-gen en_US.UTF-8

RUN rm -f /lib/systemd/system/systemd*udev* \
    && rm -f /lib/systemd/system/getty.target

CMD ["/lib/systemd/systemd"]
