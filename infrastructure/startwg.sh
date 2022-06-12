#!/bin/bash
hostsfile="serverlist"
servers=$(cat $hostsfile)
for cont in $servers
do
	 lxc exec $cont wg-quick down wg0
	 lxc exec $cont rm /etc/wireguard/wg0.conf
         lxc file push wg0/$cont.conf $cont/etc/wireguard/wg0.conf
done
#	 lxc file push infrastructure/wg0/server.conf nginxlb/etc/wireguard/wg0.conf
for cont in $servers 
do
         lxc exec $cont wg-quick up wg0

done
