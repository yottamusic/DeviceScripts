#!/bin/sh
#rmmod 88x2bu
#insmod /work/88x2bu.ko

modname="8723bu.ko"

pkill hostapd > /dev/null
pkill busybox > /dev/null
ifconfig wlan0 down
rmmod $modname

ssid=$1
passwd=$2
pkill wpa_supplicant > /dev/null
if [ ! -d /etc/wpa_supplicant ]; then
  mkdir /etc/wpa_supplicant/
fi
insmod /root/$modname
sleep 0.5
#cat cat /sys/class/net/wlan0/carrier
ifconfig wlan0 up > /dev/null
echo "ctrl_interface=/var/run/wpa_supplicant\nupdate_config=1" > /etc/wpa_supplicant/wpa.conf
echo "network={\n    ssid=\"$ssid\"\n    psk=\"$passwd\"\n    priority=1\n}" >> /etc/wpa_supplicant/wpa.conf 
wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa.conf -B > /dev/null
sleep 0.5
/root/DeviceScripts/Check_Wifi_Key.sh
ret=$?

#echo check key return=$ret

if [ $ret = 1 ]; then
  pkill dhclient > /dev/null
  dhclient wlan0 > /dev/null
  ret=$?
  if [ $ret = 0 ]; then
    printf '{"todo": "Wifi Connect", "result": "success"}'
    exit  
  fi
fi

printf '{"todo": "Wifi Connect", "result": "failure"}'
pkill wpa_supplicant > /dev/null
ifconfig wlan0 192.168.1.1 up > /dev/null
hostapd /root/hostapd.conf > /dev/null &
busybox udhcpd /root/udhcpd.conf > /dev/null
