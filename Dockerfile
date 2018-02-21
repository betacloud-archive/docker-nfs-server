FROM ubuntu:16.04
LABEL maintainer="Betacloud Solutions GmbH (https://www.betacloud-solutions.de)"

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION ${VERSION:-latest}

COPY files/run.sh /run.sh

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
CMD ["/run.sh"]
