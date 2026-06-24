#!/bin/bash

# On a RPi5, the ethernet network interface has name end0
iptables -I DOCKER-USER -i src_if -o dst_if -j ACCEPT
iptables -t nat -C POSTROUTING -o end0 -j MASQUERADE || iptables -t nat -A POSTROUTING -o end0 -j MASQUERADE
iptables -C FORWARD -i end0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT || iptables -A FORWARD -i end0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -C FORWARD -i wlan0 -o end0 -j ACCEPT || iptables -A FORWARD -i wlan0 -o end0 -j ACCEPT
iptables-save
