#!/bin/sh

SpkName=YottaSpk
#SpkName=otta

if [ "$1" = "-c" ]; then
  cnt=`iwlist wlan0 scanning | grep SSID | grep $SpkName | wc -l`
  cnt=$((cnt+1))
  printf '{"todo": "Check speaker count","result": "success","message": "'$cnt'"}\n'
fi

if [ "$1" = "-l" ]; then
  a=`cat /root/hostapd.conf | grep -i ssid`
  b=`echo ${a#*=}`
  printf '{"todo": "Check speaker list","result": "success","message": "'$b,
  iw wlan0 scan | grep SSID | grep $SpkName | awk '{printf $2 ","}'
#  printf '\b"}\n'
  printf '"}\n'
fi

