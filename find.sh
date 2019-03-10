#!/bin/sh

## VERIFY IF nmap IS INSTALLED.
## IF NOT, INSTALL IT.
NMAP_IS_INSTALLED=$(which nmap)
if test -z $NMAP_IS_INSTALLED
then
	sudo apt-get install nmap
fi

## GET NETWORK IP
ETH0_OR_WLAN_IP=$(ifconfig | grep -A 1 -E "\b[^l][[:alnum:]]+: flags\b" | grep -m 1 "inet" | awk '{ print $2 }')

## LOOK FOR RASPBERRY PI
NET=$(echo ${ETH0_OR_WLAN_IP} | grep -Eo "([0-9]{1,3}\.){3}")
SUBNET="${NET}0/24"
RASP_IP=$(sudo nmap -sP $SUBNET | grep -B 2 "Raspberry Pi Foundation" | grep -Eo "([0-9]{1,3}(\.)){3}[0-9]{1,3}")
echo $RASP_IP
