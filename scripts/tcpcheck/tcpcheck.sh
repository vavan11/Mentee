#!/bin/bash
while [ true ]; do
  sleep 2
  FIRSTHOST=$(nc -vz 192.168.56.101 514 2>&1 | grep -iow "succeeded" | wc -l)
  SECONDHOST=$(nc -vz 192.168.56.102 514 2>&1 | grep -iow "succeeded" | wc -l)
  # First host
  if [[ ${FIRSTHOST} -eq 0 ]]
  then
    iptables -t nat -F
    iptables-restore < ~/iprules/loadBalancingSecondHost.rules
    YMD_HMS_NOW=$(date +%Y%m%d-%H%M%S)
    echo "${YMD_HMS_NOW}-Syslog on host 192.168.56.102 Down!" >> /var/log/tcpcheck.log
  fi
  # Second host
  if [[ ${SECONDHOST} -eq 0 ]]
  then
    iptables -t nat -F
    iptables-restore < ~/iprules/loadBalancingFirstHost.rules
    YMD_HMS_NOW=$(date +%Y%m%d-%H%M%S)
    echo "${YMD_HMS_NOW}-Syslog on host 192.168.56.101 Down!" >> /var/log/tcpcheck.log
  fi
  # Normal
  if [[ $(expr ${SECONDHOST} + ${FIRSTHOST}) -eq 2 ]]
  then
    # Check if we have 2 Dnat rules
    if [[ $(iptables -t nat -L |grep -iow "DNAT" |wc -l) -eq 1 ]]
    then
      iptables -t nat -F
      iptables-restore < ~/iprules/loadBalancingNormal.rules
      YMD_HMS_NOW=$(date +%Y%m%d-%H%M%S)
      echo "${YMD_HMS_NOW}-Syslog hosts Up!" >> /var/log/tcpcheck.log
    fi
  YMD_HMS_NOW=$(date +%Y%m%d-%H%M%S)
  echo "${YMD_HMS_NOW}-Syslog hosts Ok!" >> /var/log/tcpcheck.log
  fi
# Everything is bad
  if [[ $(expr ${SECONDHOST} + ${FIRSTHOST}) -eq 0 ]]
  then
  YMD_HMS_NOW=$(date +%Y%m%d-%H%M%S)
  echo "${YMD_HMS_NOW}-Tow hosts Down!" >> /var/log/tcpcheck.log
  fi
done
