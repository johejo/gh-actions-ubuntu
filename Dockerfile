ARG UBUNTU_VERSION="20.04"
FROM ubuntu:$UBUNTU_VERSION
LABEL maintainer="mitsuo.heijo@gmail.com"

WORKDIR /work
ARG _UBUNTU_VERSION="2004"
ENV VIRTUAL_ENVIRONMENTS=/work/virtual-environments
ENV SCRIPTS="$VIRTUAL_ENVIRONMENTS/images/linux/scripts"
ENV HELPER_SCRIPTS="$SCRIPTS/helpers"
ENV INSTALLERS="$SCRIPTS/installers"
ENV METADATA_FILE="$VIRTUAL_ENVIRONMENTS/images/linux/ubuntu$_UBUNTU_VERSION.json"

COPY . .
RUN apt-get update && \
    apt-get install \
      lsb-release \
      sudo \
      curl \
      jq \
      wget \
      zip \
      unzip \
      apt-utils \
      gnupg-agent \
      software-properties-common \
      --no-install-recommends -y && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    bash "$SCRIPTS/base/apt.sh" && \
    bash "$SCRIPTS/base/limits.sh" && \
    bash "$SCRIPTS/base/repos.sh" && \
    find "$INSTALLERS" -name "*.sh" -maxdepth 1 | sort | xargs -I {} bash {} && \
    apt-get autoclean && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/list/* /tmp/*
