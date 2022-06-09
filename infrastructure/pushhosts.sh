#!/bin/bash
srvfile="./serverlist"
list=$(cat $srvfile)
for srv in $list
do	
	lxc file push lxchosts $srv/tmp/lxchosts
	lxc exec $srv -- bash -c " cat /tmp/lxchosts >> /etc/hosts"
	echo $srv
done 
