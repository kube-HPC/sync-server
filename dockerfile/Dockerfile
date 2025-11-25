ARG BASE_PRIVATE_REGISTRY=""
FROM ${BASE_PRIVATE_REGISTRY}hkube/base-node:v2.0.1-buster
LABEL maintainer="yehiyam@gmail.com"
ENV DOCKER_OS=linux
ENV DOCKER_ARCH=amd64


ENV release=v1.6.1

# Fix Buster EOL apt sources
RUN set -eux; \
    sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list; \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list; \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until; \
    apt-get update -o Acquire::AllowInsecureRepositories=true; \
    apt-get install -y --no-install-recommends git curl gnupg jq ca-certificates; \
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y \
     curl \
     gnupg \
     jq \
     ca-certificates \
     && gpg --keyserver keyserver.ubuntu.com --recv-key D26E6ED000654A3E \
     && set -x \
     && mkdir /syncthing \
     && cd /syncthing \
     && curl -sLO https://github.com/syncthing/syncthing/releases/download/${release}/syncthing-linux-amd64-${release}.tar.gz \
     && curl -sLO https://github.com/syncthing/syncthing/releases/download/${release}/sha256sum.txt.asc \
     && gpg --verify sha256sum.txt.asc \
     && grep syncthing-linux-amd64 sha256sum.txt.asc | sha256sum \
     && tar -zxf syncthing-linux-amd64-${release}.tar.gz \
     && mv syncthing-linux-amd64-${release}/syncthing . \
     && rm -rf syncthing-linux-amd64-${release} sha256sum.txt.asc syncthing-linux-amd64-${release}.tar.gz \
     && rm -rf /var/lib/apt/lists/*

ADD config.xml /syncthing/configOrg/config.xml
ADD startSyncthing.sh /syncthing/startSyncthing.sh

RUN npm install -g tcp-over-websockets
ENV STNOUPGRADE=1
