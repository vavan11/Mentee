#!/bin/bash
yum -y install gcc wget
wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
tar xzf Python-2.7.10.tgz
cd Python-2.7.10 && ./configure && make altinstall
yum -y update
yum -y install python-pip