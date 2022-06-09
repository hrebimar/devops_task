#!/bin/bash
cont=prometheus

lxc exec $cont -- bash -c "apt install -y prometheus"
lxc file push prometheus.yml $cont/etc/prometheus/prometheus.yml
lxc exec $cont systemctl reload prometheus

