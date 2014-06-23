docker-logstash
===============

Local testing:
docker run -d --name logstash -v /var/log/system_logs:/var/log/system_logs -p 514:514 -p 5228:5228/udp -p 5229:5229/udp choodur/logstash
