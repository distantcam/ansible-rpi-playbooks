#!/bin/sh
IPT=/sbin/iptables
LOCAL_IFACE=br0
INET_IFACE=wlan1
# Flush the tables
$IPT -F INPUT
$IPT -F OUTPUT
$IPT -F FORWARD
$IPT -t nat -P PREROUTING ACCEPT
$IPT -t nat -P POSTROUTING ACCEPT
$IPT -t nat -P OUTPUT ACCEPT

# Allow forwarding packets:
$IPT -A FORWARD -p ALL -i $LOCAL_IFACE -j ACCEPT
$IPT -A FORWARD -i $INET_IFACE -m state --state ESTABLISHED,RELATED -j ACCEPT

# Packet masquerading
$IPT -t nat -A POSTROUTING -o $INET_IFACE -j MASQUERADE

exit 0
