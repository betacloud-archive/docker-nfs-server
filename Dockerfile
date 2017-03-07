FROM ubuntu:16.04
MAINTAINER Betacloud Solutions GmbH (https://www.betacloud-solutions.de)

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION ${VERSION:-latest}

COPY files/extend_start.sh /extend_start.sh

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        netbase \
        nfs-kernel-server \
    && mkdir -p /exports \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /exports
EXPOSE 111/udp 2049/tcp
CMD ["/extend_start.sh"]
