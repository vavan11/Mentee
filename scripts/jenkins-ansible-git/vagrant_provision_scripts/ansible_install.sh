#!/bin/bash
echo "Installing Ansible..."
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y --force-yes ansible
cp -v /vagrant/ansible/ansible.cfg /etc/ansible/
cp -v /vagrant/ansible/hosts /etc/ansible/
chmod -R 644 /etc/ansible
chown -R root:root /etc/ansible
