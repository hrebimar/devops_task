#!/bin/bash
of=/tmp/logfile #output file
interval=60 #how often to repeat
while /bin/true
do
	echo "date:" >> $of
	date >> $of
	echo -e "\nload:" >> $of
	uptime | rev | cut -d: -f1 | rev | cut -d " " -f2-5 >> $of # po jednom dnu se změní struktura výpisu, takže je třeba sekat od konce
	echo -e "\nnginx stub:" >> $of
	curl nginxlb/nginx_status >> $of
	echo -e "\nnginx headers:" >> $of
	curl -I nginxlb/nginx_status >> $of
	echo -e "======================================================\n" >> $of
	sleep $interval
done
