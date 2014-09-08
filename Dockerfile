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

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz
RUN tar zxvf elasticsearch-1.1.1.tar.gz
RUN mv elasticsearch-1.1.1 /opt/elasticsearch

ADD logstash-dashboard.conf /opt/logstash/logstash-dashboard.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir /root/backups

EXPOSE 514
EXPOSE 9200
EXPOSE 9300
EXPOSE 5228
EXPOSE 5228/udp
EXPOSE 5229
EXPOSE 5229/udp

VOLUME ["/var/log/system_logs", "/root/backups"]

CMD supervisord -n
