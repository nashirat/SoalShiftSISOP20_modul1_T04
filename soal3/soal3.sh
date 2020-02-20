#!/bin/bash
wd=`pwd`

last=`ls $wd | grep "pdkt_kusuma" | cut -d "_" -f 3 | sort -n | tail -1`
if [[ $last =~ [^0-9] ]]
then
  last=0
fi

a=`expr $last + 1`
b=`expr $last + 28`

for ((i=a;i<=b;i++))
do
  wget -O $wd/"pdkt_kusuma_$i" https://loremflickr.com/320/240/cat -a $wd/wget.log
done
