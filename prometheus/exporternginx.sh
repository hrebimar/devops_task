#!/bin/bash
cont=nginxlb
lxc exec $cont -- bash -c "apt install -y prometheus-nginx-exporter && systemctl stop prometheus-nginx-exporter"
sleep 5 # nastartuje to párkrát špatně a systemd je zmatený, když se to pak pouští se správnou konfigurci
lxc file push prometheus-nginx-exporter $cont/etc/default/prometheus-nginx-exporter
lxc exec $cont -- bash -c "systemctl restart prometheus-nginx-exporter"
