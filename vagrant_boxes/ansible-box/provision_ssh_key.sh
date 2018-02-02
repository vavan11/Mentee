#!/bin/bash
mkdir -p /home/ubuntu/.ssh
cp /ubuntu/ssh/id_rsa /home/ubuntu/.ssh/id_rsa
chmod 400 /home/ubuntu/.ssh/id_rsa
cp /vagrant/ssh/id_rsa.pub /home/ubuntu/.ssh/id_rsa.pub
cat /vagrant/ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh/
