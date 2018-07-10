#!/bin/sh
#This is the script for syslog-ng installation

#---MASTER---

sudo apt install syslog-ng -y

sudo mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK

cat >> /etc/syslog/syslog-ng.conf << EOT 
@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
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
EOT

sudo mkdir /var/log/syslog-ng
sudo touch /var/log/syslog-ng/logs.txt
sudo systemctl start syslog-ng
sudo systemctl enable syslog-ng


#---MINION---

salt 'Ubu1604-Minion' cmd.run 'sudo apt install syslog-ng -y'
salt 'Ubu1604-Minion' cmd.run 'sudo mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.BAK'

salt 'Ubu1604-Minion' cmd.run 'cat <<EOT >> /etc/syslog/syslog-ng.conf
@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
source s_local { system(); internal(); };
destination d_syslog_tcp {
        syslog("10.0.0.4" transport("tcp") port(514)); };
log { source(s_local);destination(d_syslog_tcp); };
EOT'

salt 'Ubu1604-Minion' cmd.run 'sudo systemctl start syslog-ng'
salt 'Ubu1604-Minion' cmd.run 'sudo systemctl enable syslog-ng'


