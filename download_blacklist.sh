#!/bin/bash

#blacklists=("https://ftp.ntct.edu.tw/pfSense/abuse.txt" "https://ftp.ntct.edu.tw/pfSense/badguys.txt" "https://ftp.ntct.edu.tw/pfSense/block.txt" "https://ftp.ntct.edu.tw/pfSense/newest_ip.txt" "https://ftp.ntct.edu.tw/pfSense/repeated_ip.txt")
blacklists=("https://ftp.ntct.edu.tw/pfSense/newest_ip.txt")

rm blacklist.txt

for i in "${blacklists[@]}"
do
	curl "$i" >> blacklist.txt
done
