#!/bin/bash
of=/tmp/logfile #output file
interval=60 #how often to repeat
while /bin/true
do
	echo "date:" >> $of
	date >> $of
	echo -e "\nload:" >> $of
	uptime | cut -d"," -f 3-5 | cut -d " " -f 5-8 >> $of
	echo -e "\nnginx stub:" >> $of
	curl nginxlb/nginx_status >> $of
	echo -e "\n======================================================\n" >> $of
	sleep $interval
done
