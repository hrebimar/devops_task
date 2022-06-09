#!/bin/bash
for cont in {"elk1","elk2","elk3"}
do
	lxc exec $cont -- bash -c "apt install -y prometheus-elasticsearch-exporter"
done
