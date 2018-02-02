#!/bin/bash

## Install Ansible
sudo apt-get update
sudo apt-get -y install build-essential libssl-dev libffi-dev python-dev python-pip
#sudo python get-pip.py
#sudo apt-get -y purge python-pip
#sudo apt-get -y install python-pip
pip install cryptography
sudo apt-get -y install software-properties-common
sudo yes "" | apt-add-repository ppa:ansible/ansible
sudo apt-get -y install ansible
