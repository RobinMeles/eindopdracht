#!/bin/bash

apt purge apache2* -y
apt purge mysql* -y
apt purge php* -y
apt purge snmp* -y
apt purge salt* -y
rm -r /var/lib/apache2/
rm -r /var/www/html/
rm -r /etc/php/
rm -r /var/lib/php/
rm -r /etc/salt/
rm -r /var/log/salt/
rm -r /var/cache/salt/

apt-get remove salt-minion
apt-get purge salt-minion
