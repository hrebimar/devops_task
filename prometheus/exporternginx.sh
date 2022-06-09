#!/bin/bash
cont=nginxlb
lxc exec $cont -- bash -c "apt install -y prometheus-nginx-exporter && systemctl stop prometheus-nginx-exporter"
sleep 5 # nastartuje to párkrát špatně bez konfigurace a systemd je zmatený, když se to pak pouští se správnou konfigurcí a nechce nastartovat když ho pak restartnu příkazem níže 
lxc file push prometheus-nginx-exporter $cont/etc/default/prometheus-nginx-exporter
lxc exec $cont -- bash -c "systemctl restart prometheus-nginx-exporter"
