#!/bin/bash
#for i in ../infrastructure/elkservers
for i in {"elk1","elk2","elk3"}	
do
	lxc exec $i -- bash -c 'apt install -y apt-transport-https wget gnupg && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg '
	lxc exec $i -- bash -c "echo \"deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main\" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list "
       lxc exec $i -- bash -c "	apt update && apt install -y elasticsearch kibana logstash"
done
