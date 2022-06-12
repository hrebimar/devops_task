# příprava kontejnerů
echo "vytvářím kontejnery"
cd infrastructure # změna adresáře aby fungovaly relative paths, stejně jako všechny další cd
./launchcontainers.sh  # deployni a spusť kontejnery s IP adresami ze souboru
# mažu staré klíče a konfigy
rm ./wg0/*
# vytvářím klíče a konfigurace
./makekeys.sh
./makeconfigs.sh
#instaluji wg, pushuji configy a startuji wg
./installwg.sh
./startwg.sh
echo "upravuji v kontejnerech hosts"
sleep 10 #počkej aby byly kontejnery spuštěny
./pushhosts.sh # uprav na kontejnerech hosts soubor aby se servery poznaly
#nginx
echo "připravuji nginx"
cd ../nginxlb
./pushnginx.sh #nainstaluj nginx, pushni připravené nastavení a restartuj nginx
#elk
echo "instaluji elk"
cd ../elk
./installelk.sh #nainstaluj elk na všechny tři elk servery
echo "kopíruji nastavení a spouštím"
./pushelk.sh #pushni připravené soubory a porestartuj služby na všech elk serverech
#prometheus
echo "instaluji prometheus exportery na servery"
cd ../prometheus
./exporternginx.sh #nainstaluj prometheus exporter na nginx, pushni nastavení, restartuj
./exportertoelk.sh #nainstaluj exporter na elk servery, default nastavení
echo "ještě prometheus samotný"
./prometheusinstallconf.sh #nainstaluj prometheus, pushni conf a reloadni
#můj monitorovací pidiprogram
echo " a nakonec můj prográmek"
cd ../mujmonit
./mujmonit.sh # na nginxlb nainstaluje daemontools, nakopíruje můj skript do /usr/bin , připraví runfile a spustí skript. log je v /tmp/logfile

