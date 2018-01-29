#!/bin/bash

#Variables
MYSQL_ROOT_PASSWORD=password
MYSQL_USER_PASSWORD=zabbix

rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
yum -y install zabbix-server-mysql zabbix-web-mysql wget
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum -y update
yum -y install mysql-server
systemctl start mysqld
systemctl enable mysqld

# set root password

# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"

echo "$SECURE_MYSQL"


#Creating DATABASE
mysql --password=$MYSQL_ROOT_PASSWORD --user=root -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD'"
mysql --password=$MYSQL_ROOT_PASSWORD --user=root -e "CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin"
mysql --password=$MYSQL_ROOT_PASSWORD --user=root -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER,INDEX on zabbix.* TO 'zabbix'@'localhost'"
zcat /usr/share/doc/zabbix-server-mysql-3.4.6/create.sql.gz | mysql -uzabbix -p zabbix --password=$MYSQL_USER_PASSWORD

#Cp conf files
cp -v /vagrant/files/zabbix_server.conf.j2 /etc/zabbix/zabbix_server.conf
cp -v /vagrant/files/zabbix.conf.j2 /etc/httpd/conf.d/zabbix.conf

systemctl start zabbix-server
systemctl enable zabbix-server
setsebool -P httpd_can_connect_zabbix on
systemctl start httpd
systemctl enable httpd
yum -y install zabbix-agent
service zabbix-agent start