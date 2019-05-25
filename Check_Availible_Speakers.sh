#!/bin/sh

SpkName=YottaSpk
#SpkName=otta

if [ "$1" = "-c" ]; then
  cnt=`iw wlan0 scan | grep SSID | grep $SpkName | wc -l`
  printf '{"todo": "Check speaker count","result": "success","message": "'$cnt'"}\n'
fi

if [ "$1" = "-l" ]; then
  printf '{"todo": "Check speaker list","result": "success","message": "'
  iw wlan0 scan | grep SSID | grep $SpkName | awk '{printf $2 " "}'
  printf '"}\n'
fi

