FROM ubuntu:14.04
MAINTAINER choodur <tudorblink@gmail.com>

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ trusty universe' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y wget openjdk-7-jre-headless
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz
RUN tar zxvf logstash-1.4.1.tar.gz
RUN mv logstash-1.4.1 /opt/logstash

ADD logstash-dashboard.conf /opt/logstash/logstash-dashboard.conf

EXPOSE 514
EXPOSE 5228
EXPOSE 5229

VOLUME ['/var/log/system_logs']

CMD /opt/logstash/bin/logstash -f /opt/logstash/logstash-dashboard.conf