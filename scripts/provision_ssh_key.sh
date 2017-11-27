#!/bin/bash
mkdir -p /home/vagrant/.ssh
cd /home/vagrant/.ssh/
cp /vagrant/ssh/id_rsa /home/ubuntu/.ssh/id_rsa
chmod 400 id_rsa
chown -R ubuntu:ubuntu /home/vagrant/.ssh/
cp /vagrant/ssh/id_rsa.pub /home/ubuntu/.ssh/id_rsa.pub
cat /vagrant/ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown ubuntu:ubuntu /home/vagrant/.ssh/authorized_keys
