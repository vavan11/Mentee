#!/bin/bash
================================================================================
### Enablin ip forwarding
sudo sysctl -w net.ipv4.ip_forward=1
================================================================================
## Create dir
sudo mkdir -p ~/iprules/
sudo mkdir -p ~/tcpcheck/
sudo iptables -t nat -F
================================================================================
### iptables rules for load balancing
sudo iptables -t nat -A PREROUTING -i enp0s8 -p udp --dport 514 -m state --state NEW -m statistic --mode random --probability .50 -j DNAT --to-destination 192.168.56.101:514
sudo iptables -t nat -A PREROUTING -i enp0s8 -p udp --dport 514 -m state --state NEW -m statistic --mode random --probability .50 -j DNAT --to-destination 192.168.56.102:514
sudo iptables-save > /root/iprules/loadBalancingNormal.rules
sudo iptables -t nat -F
================================================================================
### First host rule
sudo iptables -t nat -A PREROUTING -i enp0s8 -p udp --dport 514 -m state --state NEW -m statistic --mode random --probability 1 -j DNAT --to-destination 192.168.56.101:514
sudo iptables-save > /root/iprules/loadBalancingFirstHost.rules
sudo iptables -t nat -F
================================================================================
### First host rule
sudo iptables -t nat -A PREROUTING -i enp0s8 -p udp --dport 514 -m state --state NEW -m statistic --mode random --probability 1 -j DNAT --to-destination 192.168.56.102:514
sudo iptables-save > /root/iprules/loadBalancingSecondHost.rules
sudo iptables -t nat -F
================================================================================
## Permission
sudo chmod 755 /root/iprules/*
sudo chown -R ubuntu:ubuntu /root/iprules/

================================================================================
## Restore iprules
sudo iptables-restore < /root/iprules/loadBalancingNormal.rules
================================================================================
## Copy Cheker
sudo cp /vagrant/tcpcheck/tcpcheck.sh /etc/tcpcheck.sh
sudo chown root:root /etc/tcpcheck.sh
sudo chmod 744 /etc/tcpcheck.sh
================================================================================
## Copy Service and start
sudo cp /vagrant/tcpcheck/tcpcheck.service /etc/systemd/system/tcpcheck.service
sudo cp /vagrant/tcpcheck/tcpcheck /etc/init.d/tcpcheck
================================================================================
sudo chown root:root /etc/systemd/system/tcpcheck.service
sudo chmod 664 /etc/systemd/system/tcpcheck.service
================================================================================
sudo chown root:root /etc/init.d/tcpcheck
sudo chmod 744 /etc/init.d/tcpcheck



## Start Service
sudo systemctl daemon-reload
sudo systemctl enable tcpcheck.service
sudo systemctl start tcpcheck.service
