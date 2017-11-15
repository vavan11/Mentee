#!/bin/bash
--------------------------------------------------------------------------------
# Check Ubuntu
if [[ $(cat /proc/version |grep -io "Ubuntu" | head -1 | wc -l) -eq 1 ]]
then
  echo -e "\e[31mInstall_python-pip_for_Ubuntu_and_boto3\e[0m"
  apt-get update && apt-get upgrade #> /dev/null 2>&1
  apt-get -y install python-pip
  #Check pip install
  if [[ $(pip --version |grep -io "pip") -eq pip ]]
  then
    echo -e "\e[31mpip_install_OK\e[0m"
  else
    echo "install pip FAILED"
    exit 1
  fi
  pip install boto3
  #check boto3
  if [[ $(pip show boto3 |grep -io "boto3" |head -1) -eq boto3 ]]
  then
    echo -e "\e[31mboto3_install_OK\e[0m"
  else
    echo "install boto3 FAILED"
    exit 1
  fi
fi
--------------------------------------------------------------------------------
# Check Centos
if [[ $(cat /proc/version |grep -io "Red" | head -1 |wc -l) -eq 1 ]]
then
  echo "\e[31mInstall_python-pip_for_Centos_and_boto3\e[0m"
  yum -y update
  yum -y install python-pip
  #Check pip install
  if [[ $(pip --version |grep -io "pip") -eq pip ]]
  then
    echo -e "\e[31mpip_install_OK\e[0m"
  else
    echo "install pip FAILED"
    exit 1
  fi
  pip install boto3
  #check boto3
  if [[ $(pip show boto3 |grep -io "boto3" |head -1) -eq boto3 ]]
  then
    echo -e "\e[31mboto3_install_OK\e[0m"
  else
    echo "install boto3 FAILED"
    exit 1
  fi
fi
