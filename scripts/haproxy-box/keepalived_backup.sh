#!/bin/bash
sudo service keepalived stop 
cp /vagrant/backup_keepalived.conf /etc/keepalived/keepalived.conf
sudo chmod 755 /etc/keepalived/keepalived.conf
sudo chown -R root:root /etc/keepalived/
sudo service keepalived start