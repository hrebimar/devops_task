#!/bin/bash
# Stopne a smaže všechny projektové kontejnery
hostsfile="../infrastructure/serverlist"
servers=$(cat $hostsfile)
for cont in $servers
do	
	 lxc stop $cont --kill
	 lxc delete $cont --force
done
