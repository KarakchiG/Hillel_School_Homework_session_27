ARG UBUNTU_TAG=20.04  # --build-arg UBUNTU_TAG=22.04
FROM ubuntu:${UBUNTU_TAG}

ENV TZ=Asia/Jerusalem
ENV USERNAME=jenkins
ENV GROUPNAME=ht
ENV UID=10642
ENV GID=10600
ENV ONEDRIVE_DIR="OneDrive"

# Timezone setting is needed to prevent interactive prompt during image setup
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
&& echo $TZ > /etc/timezone \
&& bash -c 'mkdir -p /etc/udev/rules.d \
        /lib/firmware \
        /lib/udev/rules.d'

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  cmake \
  gcc-9 \
  g++-9 \
  git \
  curl \
  libnotify-dev \
  openssh-client \
  pciutils \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-virtualenv \
  python3-pybind11 \
  python3-gi \
  python-gi-dev \
  python3-tk \
  sudo \
  vim \
  virtualenv \
  unzip \
  wget \
  libcurl4-openssl-dev \
  libsqlite3-dev \
  pkg-config \
  software-properties-common \
  apt-utils

  
#ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN groupadd --gid ${GID} ${GROUPNAME} \
  && useradd -m -s /bin/bash --gid ${GROUPNAME} -G sudo -u ${UID} ${USERNAME} \
  && chmod u+w /etc/sudoers \
  && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  && chmod -w /etc/sudoers \
  && echo "" > /etc/bash.bashrc \
  && chown -R ${USERNAME}:${GROUPNAME} /home/${USERNAME} \
  && echo "umask 000" >> /home/${USERNAME}/.bashrc

# after this point all commands being run as ${USERNAME}
RUN su ${USERNAME}
RUN mkdir /home/${USERNAME}/${ONEDRIVE_DIR}
RUN chown -R ${USERNAME}:${GROUPNAME} /home/$USERNAME/${ONEDRIVE_DIR}

WORKDIR /home/$USERNAME/${ONEDRIVE_DIR}


RUN sudo add-apt-repository ppa:yann1ck/onedrive
RUN sudo apt-get update
RUN sudo apt-get install onedrive -y

#  --syncdir ARG   Specify the local directory used for synchronization to OneDrive


USER ${USERNAME}:${GROUPNAME}


# Banner copy
COPY bash.bashrc /etc/bash.bashrc


ENTRYPOINT /bin/bash
CMD ls