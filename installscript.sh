#!/bin/sh

# Installeren van cacti op monitor/master

apt-get update
apt-get upgrade

apt-get install snmpd 
apt-get install snmp 
apt-get install mysql-server 
apt-get install apache2 
apt-get install libapache2-mod-php5
apt-get install php5-mysql
apt-get install php5-cli 
apt-get install php5-snmp

apt-get install cacti



#minion

apt-get install snmp snmpd

sed -i 
