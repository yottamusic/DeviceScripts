#!/bin/sh
#rmmod 88x2bu
#insmod /work/88x2bu.ko
pkill hostapd
ifconfig wlan0 down
ssid=$1
passwd=$2
pkill wpa_supplicant
`mkdir /etc/wpa_supplicant/`
ifconfig wlan0 0.0.0.0 up
echo "network={\n    ssid=\"$ssid\"\n    psk=\"$passwd\"\n    priority=1\n}"   >/etc/wpa_supplicant/wpa_supplicant.conf 
wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf  &
sleep 3
dhclient wlan0

sleep 1
a=$?

if [ $a = 0 ]; then
  printf '{"todo": "Wifi Connect", "result": "success"}\n'
else
  printf '{"todo": "Wifi Connect", "result": "failure"}\n' 
fi

