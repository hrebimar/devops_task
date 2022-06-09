#!/bin/bash
hostsfile="./serverlist"
servers=$(cat $hostsfile)
for cont in $servers
do
	lxc  launch -n cdnnet images:debian/bullseye "$cont"
	ip=$(grep $cont lxchosts | cut -d " " -f 1)
	echo $ip
#	lxc network attach cdnnet $cont eth0 eth0
	lxc config device set $cont eth0 ipv4.address $ip
	lxc start $cont
done
