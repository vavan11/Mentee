#!/bin/bash
sudo service keepalived stop 
sudo cp /vagrant/master_keepalived.conf /etc/keepalived/keepalived.conf
sudo chmod 755 /etc/keepalived/keepalived.conf
sudo chown -R root:root /etc/keepalived/
sudo service keepalived start