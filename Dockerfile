FROM ubuntu:latest

MAINTAINER toussoul 

WORKDIR /opt

# Base packages
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get install -y --no-install-recommends autoconf automake bison build-essential bzip2 ca-certificates curl g++ gawk gcc git libc6-dev libffi-dev libgdbm-dev libncurses5-dev libreadline6 libreadline6-dev libsqlite3-0 libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libyaml-dev make openssl patch pkg-config procps sqlite3 subversion zlib1g zlib1g-dev && rm -rf /var/lib/apt/lists/* \
    && localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8

ENV TERM=xterm
ENV LC_ALL fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

RUN mkdir -p /opt/beef/ && chmod 777 /opt/beef/ -R


RUN cd /opt/beef/ && \
    git clone git://github.com/beefproject/beef.git 

RUN chmod 777 /opt/beef/ -R

RUN cd /opt/beef/beef && \
    bundle install

ADD config.yaml beef/config.yaml

EXPOSE 3000

WORKDIR /opt/beef/beef

CMD ./beef