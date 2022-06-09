#!/bin/bash
srv="nginxlb"
lxc exec $srv -- bash -c "apt install -y nginx"
lxc exec $srv systemctl stop nginx
lxc exec $srv -- bash -c "rm -rf /etc/nginx"
lxc file push -r ./nginx $srv/etc
lxc exec $srv systemctl start nginx
