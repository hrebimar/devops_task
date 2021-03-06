#!/bin/bash

#if [[ $# -ne 1 ]]; then echo "Zadej pouze jeden parametr - nazev klienta"; exit 1;fi

#newIP=$(echo "10.20.30.$(($(cat wg0.conf | grep AllowedIPs | awk '{print $3}' | sed 's/\/32//g' | sort -t . -k 3,3n -k 4,4n | tail -n 1 | awk -F'.' '{print $4}')+1))")
#mkdir wg0/${1}

IP=$(echo $1 | cut -d " " -f 1 )
hostname=$(echo $1 | cut -d " " -f 2)


wg genkey | tee wg0/${hostname}.private | wg pubkey > wg0/${hostname}.public

cat <<EOF >> wg0/server.conf
[Peer]
# ${hostname}
PublicKey = $(cat wg0/${hostname}.public)
AllowedIPs = ${IP}/32
PersistentKeepalive = 15

EOF

cat <<EOF >> wg0/${hostname}.conf
[Interface]
PrivateKey = $(cat wg0/${hostname}.private)
Address = ${IP}/24

[Peer]
PublicKey = $(cat wg0/server.public)
AllowedIPs = 10.20.30.0/24 
Endpoint = $(cat wg0/server.ip):56711
PersistentKeepalive = 15
EOF

#qrencode -t png -r wg0/${1}/${1}.conf -o wg0/${1}/${1}.png

#systemctl restart wg-quick@wg0.service
