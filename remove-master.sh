#!/bin/bash

mysql --user="root" --password="root" --database="cacti" -e "DROP DATABASE cacti;"

salt-key -d '*'
apt purge syslog-ng* -y
apt purge apache2* -y
apt purge mysql* -y
apt purge php* -y
apt purge salt* -y
apt purge snmp* -y
apt purge snmpd* -y
apt purge cacti* -y
apt purge syslog-ng -y
apt purge --auto-remove syslog-ng
rm -r /var/www/html/
rm -r /etc/php/
rm -r /var/lib/php/
rm -r /srv/salt/
rm -r /etc/salt/
rm -r /var/log/salt/
rm -r /var/cache/salt/
rm -r /etc/syslog-ng

