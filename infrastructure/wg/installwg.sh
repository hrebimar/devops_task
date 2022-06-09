#!/bin/bash
hostsfile="serverlist"
servers=$(cat $hostsfile)
for cont in $servers
do	
	 lxc exec $cont -- bash -c "apt install -y wireguard"
done
