#!/bin/bash
srvfile="./serverlist"
list=$(cat $srvfile)
for srv in $list
do	
	lxc file push hosts $srv/tmp/hosts
	lxc exec $srv -- bash -c " cat /tmp/hosts >> /etc/hosts"
	echo $srv
done 
