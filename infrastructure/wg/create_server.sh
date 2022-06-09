server=$(grep $1 hosts | cut -d " " -f 2)
serverip=$(lxc list | grep $1 | cut -d "|" -f 4 | cut -d " " -f 2)

wg genkey | tee wg0/server.private | wg pubkey > wg0/server.public
echo $serverip > wg0/server.ip

cat <<EOF >> wg0/server.conf
[Interface]
# server
PrivateKey = $(cat wg0/server.public)
Address = 10.20.30.11/24
ListenPort=56711

EOF



