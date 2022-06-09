#!/bin/bash

for i in {"elk1","elk2","elk3"}
do                                                                                                                                                                                   
	echo "pracuju na $i"
	lxc file push elastic/jvm.options $i/etc/elasticsearch/jvm.options
	lxc file push elastic/$i $i/etc/elasticsearch/elasticsearch.yml  
	echo "restartuju elastic"
	lxc exec $i systemctl restart elasticsearch
	lxc file push logstash/jvm.options $i/etc/logstash/jvm.option
	echo "restartuju logstash"
	lxc exec $i systemctl restart logstash
	lxc file push kibana/kibana.yml $i/etc/kibana/kibana.yml
	echo "restartuju kibanu"
	lxc exec $i systemctl restart kibana
done   
