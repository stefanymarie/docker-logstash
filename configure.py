#!/usr/bin/env python

from string import Template
import os
tmpl = """
input {
  udp {
    host => "0.0.0.0"
    port => 5228
    codec => json_lines
    type => "dashboard"
  }
  syslog {
    host => "0.0.0.0"
    port => 5229
    type => "system"
  }
}
output {
  file {
    codec => json_lines
    path => "/var/log/system_logs/%{host}/%{program}.log"
  }
  elasticsearch {
    host => "$elasticsearch_host"
    index => "%{host}_%{program}_%{+dd.MM.YY}"
  }
}
"""
s = Template(tmpl)
out = s.substitute(elasticsearch_host=os.environ['ELASTICSEARCH_PORT_9200_TCP_ADDR'])
f = open('/opt/logstash/logstash-dashboard.conf', 'w')
f.write(out)
f.close()