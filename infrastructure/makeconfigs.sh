#!/bin/bash
hosts="./hosts"
while read server;
do
echo $server
	ip=$(echo $server | cut -d " " -f 1)
	hostname=$(echo $server | cut -d " " -f 2)

cat <<EOF > wg0/$hostname.conf
[Interface]
# ${hostname}
PrivateKey = $(cat wg0/${hostname}.private)
Address = ${ip}/24
ListenPort = 52800

EOF

while read peer;
do
if [ "$server" != "$peer" ]; then
peername=$(echo $peer | cut -d " " -f 2) 
peerip=$(grep $peername lxchosts |cut -d" " -f1)
peerinternal=$(echo $peer | cut -d " " -f 1)

cat <<EOF >> wg0/${hostname}.conf
[Peer]
#$peername
PublicKey = $(cat wg0/${peername}.public)
AllowedIPs = $peerinternal/32 
Endpoint = $peerip:52800
PersistentKeepalive = 15

EOF
fi
done <hosts
done < hosts
