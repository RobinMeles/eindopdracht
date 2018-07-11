#!/bin/bash

mysql --user="root" --password="root" --database="cacti" -e "DROP DATABASE cacti;"

salt-key -d '*'
apt purge apache2* -y
apt purge mysql* -y
apt purge php* -y
apt purge salt* -y
apt purge rsyslog-mysql -y
apt purge snmp* -y
apt purge zip -y
apt purge unzip -y
apt purge rddtool -y
rm -r /var/www/html/
rm -r /etc/php/
rm -r /var/lib/php/
rm -r /srv/salt/
rm -r /etc/salt/
rm -r /var/log/salt/
rm -r /var/cache/salt/
rm -r /home/andres/cacti*

apt-get purge docker-ce -y
rm -rf /var/lib/docker
