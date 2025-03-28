FROM ubuntu:24.04

MAINTAINER sam

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get install -y locales

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y \
    ca-certificates \
    software-properties-common \
    lib32gcc-s1 \
    libstdc++6 \
    curl \
    wget \
    build-essential

USER root

RUN mkdir -p /steamcmd
RUN mkdir -p /starbound
VOLUME ["/starbound"]
RUN cd /steamcmd \
        && wget -o /tmp/steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
        && tar zxvf steamcmd_linux.tar.gz \
        && rm steamcmd_linux.tar.gz \
        && chmod +x ./steamcmd.sh


ADD start.sh /start.sh

ADD update.sh /update.sh

# Add initial require update flag
ADD .update /.update

WORKDIR /

EXPOSE 28015
EXPOSE 28016

ENV STEAM_LOGIN FALSE

ENV DEBIAN_FRONTEND newt

ENTRYPOINT ["./start.sh"]
