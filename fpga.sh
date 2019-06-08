#!/bin/sh

cd /root

insmod sdio_raw.ko
mknod /dev/sdioa c 140 1
mknod /dev/sdiob c 141 1
mknod /dev/sdioc c 142 1

ifconfig eth0 down

#udhcpc eth0

#insmod 8192eu.ko
insmod /root/cfg80211.ko
insmod 8723bu.ko
ifconfig wlan0 192.168.1.1 up
hostapd hostapd.conf &
#busybox udhcpd udhcpd.conf

# insmod ip_tables
# please copy all files in /lib/modules/4.13.16
modprobe ip_tables
modprobe nf_conntrack 
modprobe nf_nat                
modprobe nf_defrag_ipv4        
modprobe nf_defrag_ipv6        
modprobe nf_nat_ipv4           
modprobe nf_conntrack_ipv4     
modprobe nf_nat_ipv6           
modprobe nf_conntrack_ipv6     
modprobe iptable_nat           
modprobe xt_nat  

# now start iptables
iptables -t nat -A PREROUTING -d 0/0 -p tcp --dport 80 -j REDIRECT --to-port 80

# now start DNS server and DHCP server
dnsmasq

sleep 2

busybox devmem 0x1c20828 32 0x00777770
export LD_LIBRARY_PATH=/opt/lib
./carplayer /storage YottaCar /work/uuid_rdr /run/shm &


sleep 2

./d.sh
/root/DeviceConfig &

exit 0

