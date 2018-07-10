#!/bin/sh

# Installeren van cacti op monitor/master

apt-get update
apt-get upgrade

apt-get install snmpd -y
apt-get install snmp -y
apt-get install mysql-server -y
apt-get install apache2 -y
apt-get install libapache2-mod-php5 -y
apt-get install php5-mysql -y
apt-get install php5-cli -y
apt-get install php5-snmp -y

apt-get install cacti -y



#minion

salt 'Ubu1604-Minion' cmd.run 'apt-get install snmp -y'
salt 'Ubu1604-Minion' cmd.run 'apt-get install snmpd -y'
