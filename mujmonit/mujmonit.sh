#!/bin/bash
cont=nginxlb
#cont=$1 #uncomment to pass different cont as argument 
lxc exec $cont -- bash -c "apt install -y daemontools daemontools-run curl" #curl aby pak skript fungoval
lxc file push ./skript.sh $cont/usr/bin/mujmonit.sh
lxc exec $cont -- bash -c 'mkdir -p /etc/service/mujmonit && echo -e "#!/bin/bash \nexec /usr/bin/mujmonit.sh" > /etc/service/mujmonit/run && chmod +x /etc/service/mujmonit/run'
