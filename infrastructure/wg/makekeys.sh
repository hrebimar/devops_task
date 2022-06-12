#!/bin/bash
hosts="./hosts"
while read server;
do
echo $server
ip=$(echo $server | cut -d " " -f 1)
hostname=$(echo $server | cut -d " " -f 2)
wg genkey | tee wg0/${hostname}.private | wg pubkey > wg0/${hostname}.public
done < hosts
