#!/bin/bash
hostsfile="serverlist"
servers=$(cat $hostsfile)
for cont in $servers
do	
	 lxc stop $cont
	 lxc delete $cont
done
