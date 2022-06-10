#!/bin/bash
cont=nginxlb
#cont=$1 #odkomentovat, když chci nainstalovat na jiný server zadaný jako argument 
lxc exec $cont -- bash -c "apt install -y daemontools daemontools-run curl" #curl instalovat aby pak fungoval můj skript
lxc file push ./skript.sh $cont/usr/bin/mujmonit.sh
lxc exec $cont -- bash -c 'mkdir -p /etc/service/mujmonit && echo -e "#!/bin/bash \nexec /usr/bin/mujmonit.sh" > /etc/service/mujmonit/run && chmod +x /etc/service/mujmonit/run'
