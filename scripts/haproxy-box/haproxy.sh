#!/bin/bash
sudo apt-get update 
sudo apt-get -y upgrade
sudo apt-get -y install haproxy haproxyctl
sudo systemctl stop haproxy
sudo rm -rf /etc/haproxy/haproxy.cfg
sudo cp /vagrant/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo systemctl start haproxy
