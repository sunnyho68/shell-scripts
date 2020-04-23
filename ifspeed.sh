#!/bin/bash

if [ -z "$1" ]; then
	echo example: $0 eth0
	exit
fi

if [ ! -d "/sys/class/net/$1" ]; then
	echo "No such interface: $1"
	exit
fi

while true
do
	tx_packets_1=$( < /sys/class/net/$1/statistics/tx_packets)
	rx_packets_1=$( < /sys/class/net/$1/statistics/rx_packets)
	tx_bytes_1=$( < /sys/class/net/$1/statistics/tx_bytes)
	rx_bytes_1=$( < /sys/class/net/$1/statistics/rx_bytes)
	sleep 1
	tx_packets_2=$( < /sys/class/net/$1/statistics/tx_packets)
	rx_packets_2=$( < /sys/class/net/$1/statistics/rx_packets)
	tx_bytes_2=$( < /sys/class/net/$1/statistics/tx_bytes)
	rx_bytes_2=$( < /sys/class/net/$1/statistics/rx_bytes)
	tx_pps=$(( $tx_packets_2 - $tx_packets_1 ))
	rx_pps=$(( $rx_packets_2 - $rx_packets_1 ))
	tx_KBps=$(( ($tx_bytes_2 - $tx_bytes_1) / 1024 ))
	rx_KBps=$(( ($rx_bytes_2 - $rx_bytes_1) / 1024 ))
	echo "TX/RX(pps): $tx_pps / $rx_pps TX/RX(KBps): $tx_KBps / $rx_KBps"
done

