FROM debian:latest

MAINTAINER toussoul 

ENV TERM=xterm
ENV LC_ALL fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

WORKDIR /opt
    
RUN mkdir -p /opt/beef/ && chmod 777 /opt/beef/ -R

RUN apt-get install git && \
    cd /opt/beef/ && \
    git clone https://github.com/toussoul/beef.git 

RUN chmod 777 /opt/beef/ -R && \
    useradd -m beef && \
    echo "beef    ALL=NOPASSWD: ALL" >> /etc/sudoers

USER beef

ENV TERM=xterm
ENV LC_ALL fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

RUN cd /opt/beef/beef && \
    echo "y " | ./install

ADD config.yaml config.yaml

EXPOSE 3000
RUN gem install --no-rdoc --no-ri bundler

WORKDIR /opt/beef/beef

CMD ./beef
