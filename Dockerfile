FROM ubuntu:14.04
MAINTAINER choodur <tudorblink@gmail.com>

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ trusty universe' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y wget openjdk-7-jre-headless

RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
RUN tar zxvf logstash-1.4.2.tar.gz
RUN mv logstash-1.4.2 /opt/logstash

EXPOSE 514

VOLUME ['/var/log/system_logs']

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD supervisord -n