#!/bin/sh

#installing salt master

apt-get update
apt-get upgrade -y

wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

echo deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main >> /etc/apt/sources.list.d/saltstack.list
sudo apt-get update

sudo apt-get install salt-master -y

sudo systemctl restart salt-master

sudo sed -i 's/#interface 0.0.0.0/interface 10.0.0.4/' /etc/salt/master

salt-key -A
