#!/bin/bash

#for i in ../infrastructure/elkservers
for i in {"elk1","elk2","elk3"}
do                                                                                                                                                                                   
	echo $i                                                                                                                                                                      
	lxc file push elastic/jvm.options $i/etc/elasticsearch/jvm.options
	lxc file push elastic/$i $i/etc/elasticsearch/elasticsearch.yml  
	echo "restartuju elastic,trvá to"
	lxc exec $i systemctl restart elasticsearch
	echo "elastic restartován"
	lxc file push logstash/jvm.options $i/etc/logstash/jvm.option
	echo "restartuju logstáš, trvá to"
	lxc exec $i systemctl restart logstash
	echo " logstáš restartován"
	lxc file push kibana/kibana.yml $i/etc/kibana/kibana.yml
	echo "restartuju kibanu"
	lxc exec $i systemctl restart kibana
	echo "kibana restartnuta"
done   
