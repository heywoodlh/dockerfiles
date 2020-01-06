#!/bin/bash
## Taken from http://www.queryadmin.com/2215/route-all-internet-traffic-through-tor-on-linux-debian/

# destinations you don't want routed through Tor
NON_TOR="10.0.0.0/8 100.64.0.0/10 172.16.0.0/12 192.0.0.0/24 192.168.0.0/16 198.18.0.0/15"
 
# the UID Tor runs as (generally is 108 or 109)
TOR_UID=`id -u debian-tor`
 
# Tor's TransPort (same as wrote on /etc/tor/torrc)
TRANS_PORT="9040"
 
iptables -F
/usr/sbin/iptables -t nat -F
 
/usr/sbin/iptables -t nat -A OUTPUT -m owner --uid-owner $TOR_UID -j RETURN
/usr/sbin/iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 53
for NET in $NON_TOR 127.0.0.0/9 127.128.0.0/10; do
 /usr/sbin/iptables -t nat -A OUTPUT -d $NET -j RETURN
done
/usr/sbin/iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports $TRANS_PORT
 
/usr/sbin/iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
for NET in $NON_TOR 127.0.0.0/8; do
 /usr/sbin/iptables -A OUTPUT -d $NET -j ACCEPT
done
/usr/sbin/iptables -A OUTPUT -m owner --uid-owner $TOR_UID -j ACCEPT
/usr/sbin/iptables -A OUTPUT -j REJECT
