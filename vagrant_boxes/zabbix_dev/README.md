This vagrant box installs ZABBIX 3.5

## Prerequisites

[VirtualBox](https://www.virtualbox.org/), [Vagrant](http://www.vagrantup.com/)

## Up and SSH

To start the vagrant box open cmd and go to 'zabbix_dev' folder and run:

    vagrant up

To log in to the machine run:

    vagrant ssh

Zabbix will be available on the host machine at [http://192.168.56.50/zabbix) 

Zabbix db password: zabbix

Web

Login: Admin
Password: zabbix


## Vagrant commands


```
vagrant up # starts the machine
vagrant ssh # ssh to the machine
vagrant halt # shut down the machine
```


