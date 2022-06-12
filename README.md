# devops_task

Repozitář obsahuje skripty ve stavu připraveném ke spuštění autoinstall.sh . Skript postupně spouští dílčí skripty, které postupně deployují kontejnery a na nich pak spouští služby na základě připravených konfigurací.
Řešení je realizováno v lxc kontejnerech a k funkčnosti je třeba aby v lxc fungoval network cdnnet s rozsahen 10.250.112.1/24 . Je třeba aby kontejnery mohly komunikovat s internetem, aby bylo možno stahovat data z repozitářů.
Pro nastavení potřebné sítě je připraven v helpers/createnetwork.sh oneliner, který by měl sám zvládnout potřebnou bridge network vytvořit. Na fw na podkladovém serveru jsem již nic dalšího nenastavoval.

Jako distribuovaný systém jsem zvolil ELK stack. Konfigurován je na 3 servery tak, aby po nastavení indexů na dvě repliky odolal výpadku dvou serverů Kibana a logstash jsou též na všech třech serverech, aby fungoval v případě výpadku celý stack.

Nginx servíruje na portu 80 defaultní stránku, na portu 81 je základní nginx cache, která cacheuje requesty s odezvou 200 po dobu 15s. Nginx status (stub response) je na portu 80 na adrese http:///10.250.112.11/nginx_status .

Prometheus má jako targety nastaveny běžné exportery pro služby běžící na ostatních kontejnerech. Je pro něj ještě na nginx serveru nastavena proxy na port 8100, primárně určena pro kontrolu v průběhu vytváření deploy skriptů.

Vlastní skript napsaný v bashi sbírá load metriku, response status nginx, hlavičky a IP kontejnerů, na které se dá připojit přes VPN a ukládá je každou minutu do souboru /tmp/logfile

Repozitář ještě obsahuje skripty pro deploy wg sítě, tu se mi ale bohužel zatím nepodařilo zprovoznit, proto nejsou zahrnuty

Edit 12.6. - wg zprovozněn a skripty předělány tak aby kontejnery komunikovaly přes wg síť
