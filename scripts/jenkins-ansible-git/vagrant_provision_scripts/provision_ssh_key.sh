#!/bin/bash

#user vagrant
mkdir -p /home/vagrant/.ssh
cp /vagrant/ssh/id_rsa /home/vagrant/.ssh/id_rsa
chmod 400 /home/vagrant/.ssh/id_rsa
cp /vagrant/ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
cat /vagrant/ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh/

#user root
mkdir -p /root/.ssh
cp /vagrant/ssh/id_rsa /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa
cp /vagrant/ssh/id_rsa.pub /root/.ssh/id_rsa.pub
cat /vagrant/ssh/id_rsa.pub >> /root/.ssh/authorized_keys
# config for root
touch /root/.ssh/config
cat << EOF > /root/.ssh/config
Host *
    StrictHostKeyChecking no
	User *
EOF
chmod 400 /root/.ssh/config
chown -R root:root /root/.ssh/