rm wg0/*
bash ./create_server.sh nginxlb
while read p; do bash ./add-client.sh "$p"; done < hosts
