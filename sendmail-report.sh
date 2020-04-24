#!/bin/sh

date=`date +%Y%m%d`
basedir="/home/mailreport/"

cd $basedir

echo "From: report<report@mail.address>" > report
echo "To: operator<operator@mail.address>" >> report
echo "Subject: subject here $date" >> report
echo >> report
echo "some contents here" >> report
echo >> report

/usr/sbin/sendmail operator@mail.address < report
rm report

