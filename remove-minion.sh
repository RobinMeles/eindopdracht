#!/bin/bash

apt purge apache2* -y
apt purge mysql* -y
apt purge php* -y
apt purge snmp* -y
apt purge snmpd* -y
apt purge salt* -y
apt purge syslog-ng -y
apt purge --auto-remove syslog-ng -y
rm -r /var/lib/apache2/
rm -r /var/www/html/
rm -r /etc/php/
rm -r /var/lib/php/
rm -r /etc/salt/
rm -r /var/log/salt/
rm -r /var/cache/salt/

