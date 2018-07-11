#!/bin/sh

#--SALT-MASTER--

apt-get update
apt-get upgrade -y

wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

echo deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main >> /etc/apt/sources.list.d/saltstack.list
sudo apt-get update

sudo apt-get install salt-master -y

sudo systemctl restart salt-master

sudo sed -i 's/#interface 0.0.0.0/interface 10.0.0.4/' /etc/salt/master

salt-key -A

salt-master

# Installeren van cacti op monitor/master

apt-get update
apt-get upgrade -y

apt-get install snmpd -y
apt-get install snmp -y
apt-get install mysql-server -y
apt-get install apache2 -y
apt-get install libapache2-mod-php5 -y
apt-get install php5-mysql -y
apt-get install php5-cli -y
apt-get install php5-snmp -y

apt-get install cacti -y

# Installervan snmp/snmpd voor cacti op minion

salt 'Ubu1604-Minion' cmd.run 'apt-get install snmp -y'
salt 'Ubu1604-Minion' cmd.run 'apt-get install snmpd -y'

#---SYSLOG-NG MASTER---

sudo apt-get install syslog-ng -y

sudo mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK

cat << EOF >> /etc/syslog-ng/syslog-ng.conf 
@version: 3.5
@include "scl.conf"
@include "scl-root/system/tty10.conf"
        options {
                time-reap(30);
                mark-freq(10);
                keep-hostname(yes);
                };
        source s_local { system(); internal(); };
        source s_network {
                syslog(transport(tcp) port(514));
                };
        destination d_local {
        file("/var/log/syslog-ng/messages_${HOST}"); };
        destination d_logs {
                file(
                        "/var/log/syslog-ng/logs.txt"
                        owner("root")
                        group("root")
                        perm(0777)
                        ); };
        log { source(s_local); source(s_network); destination(d_logs); };
EOF

sudo mkdir /var/log/syslog-ng
sudo touch /var/log/syslog-ng/logs.txt
sudo systemctl start syslog-ng
sudo systemctl enable syslog-ng


#---SYSLOG-NG MINION---

salt 'Ubu1604-Minion' cmd.run 'sudo apt-get install syslog-ng -y'
salt 'Ubu1604-Minion' cmd.run 'sudo mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK'

salt 'Ubu1604-Minion' cmd.run 'cat << EOF >> /etc/syslog-ng/syslog-ng.conf
@version: 3.5
@include "scl.conf"
@include "scl-root/system/tty10.conf"
source s_local { system(); internal(); };
destination d_syslog_tcp {
        syslog("10.0.0.4" transport("tcp") port(514)); };
log { source(s_local);destination(d_syslog_tcp); };
EOF'

salt 'Ubu1604-Minion' cmd.run 'sudo systemctl start syslog-ng'
salt 'Ubu1604-Minion' cmd.run 'sudo systemctl enable syslog-ng'
