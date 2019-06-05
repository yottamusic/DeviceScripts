#!/bin/sh

if [ $# != 2 ]; then
  exit 0
fi

name=`iwlist wlan0 scanning | grep SSID | grep $1`
if [ "$name" = "" ]; then
  a=`cat /root/hostapd.conf | grep ssid | grep $1`
  if [ "$a" = "" ]; then
    exit 0
  fi
fi

if [ "$2" = "mono" ]; then
  # other commands herer
  printf '{"todo": "Set Mono Mode '$1'", "result": "success"}\n'
fi

if [ "$2" = "stereo" ]; then
  # other commands herer
  printf '{"todo": "Set Stereo Mode '$1'", "result": "success"}\n'
fi


