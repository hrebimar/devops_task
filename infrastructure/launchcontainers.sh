#!/bin/bash
hostsfile="./serverlist"
servers=$(cat $hostsfile)
for cont in $servers
do
	lxc  launch -n cdnnet images:debian/bullseye "$cont"
	ip=$(grep $cont lxchosts | cut -d " " -f 1)
	echo $ip
	lxc config device set $cont eth0 ipv4.address $ip
	lxc stop $cont
	lxc start $cont
done
