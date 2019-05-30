#!/bin/sh

SpkName=YottaSpk
#SpkName=otta

printf '{"todo": "Check Available SSID","result": "success","message": "'

ssidFile=/run/shm/ssidlist
ssidutf8=/run/shm/ssidutf8

#iw wlan0 scan | grep SSID | grep -v $SpkName | awk '{printf $2 ","}'
iwlist wlan0 scanning | grep SSID | grep -v $SpkName > /run/shm/ssidlist

/root/ssid GBK $ssidFile > $ssidutf8

cat $ssidutf8 | while read line
do
  a=`echo ${line#*\"}`
  b=`echo ${a%\"*}`
  if [ "$b" = "" ]; then
    #echo ignore empty line ...
    continue
  fi
  #echo line=$line a=$a SSID:$b
  printf $b,
done


printf '\b"}\n'


