#!/bin/bash
mkdir -p /home/vagrant/.ssh
cd /home/vagrant/.ssh/
cp /vagrant/ssh/id_rsa id_rsa
chmod 400 id_rsa
chown -R vagrant:vagrant /home/vagrant/.ssh/
cp /vagrant/ssh/id_rsa.pub id_rsa.pub
cat /vagrant/ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
