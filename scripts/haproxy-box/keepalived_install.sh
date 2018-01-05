#!/bin/bash
sudo apt install -y keepalived
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p
sudo sysctl -w net.ipv4.ip_forward=1

sudo iptables -I INPUT -i enp0s8 -d 224.0.0.0/8 -p vrrp -j ACCEPT
sudo iptables -I OUTPUT -o enp0s8 -d 224.0.0.0/8 -p vrrp -j ACCEPT
sudo iptables-save > /root/keepalived.rules

