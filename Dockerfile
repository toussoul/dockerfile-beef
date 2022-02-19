FROM ubuntu:latest

MAINTAINER toussoul 

WORKDIR /opt

# Base packages
RUN apt-get update && apt-get install -y locales git bundler nodejs libsqlite3-dev && rm -rf /var/lib/apt/lists/* \
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