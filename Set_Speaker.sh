#!/bin/sh

if [ $# != 2 ]; then
  exit 0
fi

name=`iw wlan0 scan | grep SSID | grep $2`
if [ "$name" = "" ]; then
  exit 0
fi

if [ "$1" = "Mono" ]; then
  # other commands herer
  printf '{"todo": "Set Mono Mode", "result": "success"}\n'
fi

if [ "$1" = "Stereo" ]; then
  # other commands herer
  printf '{"todo": "Set Stereo Mode", "result": "success"}\n'
fi


