#!/bin/bash

MY_SQL_PASS=password
ZABBIX_DB=zabbix
DB_USER_ZABBIX=zabbix
DB_USER_PASS=zabbix

apt update && apt -y upgrade

export DEBIAN_FRONTEND="noninteractive"
debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MY_SQL_PASS}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MY_SQL_PASS}"
apt-get install -y mysql-server 
apt-get install -y mysql-client apache2

wget http://repo.zabbix.com/zabbix/3.5/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.5-1+xenial_all.deb
dpkg -i zabbix*.deb
apt-get update
apt-get install -y zabbix-server-mysql zabbix-frontend-php
apt-get -f install

cp -v /vagrant/files/zabbix_server.conf /etc/zabbix/zabbix_server.conf
cp -v /vagrant/files/apache.conf /etc/zabbix/apache.conf
chmod 644 /etc/zabbix/zabbix_server.conf
chmod 644 /etc/zabbix/apache.conf

mysql --password=${MY_SQL_PASS} --user=root -e "CREATE DATABASE ${ZABBIX_DB} CHARACTER SET utf8 COLLATE utf8_bin;"
mysql --password=${MY_SQL_PASS} --user=root -e "CREATE USER '${DB_USER_ZABBIX}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"
mysql --password=${MY_SQL_PASS} --user=root -e "GRANT ALL PRIVILEGES ON ${ZABBIX_DB}.* TO '${DB_USER_ZABBIX}'@'localhost';"
mysql --password=${MY_SQL_PASS} --user=root -e "FLUSH PRIVILEGES;"
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql --user=$DB_USER_ZABBIX -p zabbix --password=$DB_USER_PASS

apt -y install zabbix-agent

systemctl start zabbix-server.service
systemctl enable zabbix-server.service
sudo systemctl restart apache2.service
systemctl start zabbix-agent.service
systemctl enable zabbix-agent.service

#https://packages.debian.org/sid/all/zabbix-java-gateway/download