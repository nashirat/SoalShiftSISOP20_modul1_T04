#!/bin/bash
wd=`pwd`

a=`ls $wd | grep "pdkt_kusuma" | cut -d "_" -f 3 | sort -n | tail -1`
ar=""

for ((i=1;i<=a;i++))
do
  loc="`grep "Location" $wd/wget.log | cut -d "_" -f 3 | head -$i | tail -1`"
  flag=`echo -e $ar | awk -v loc=$loc 'BEGIN {flag=0} {if (loc==$0) flag=1} END {printf "%d", flag}'`
  if [[ $flag == 0 ]]
  then
    ar="$ar$loc\n"
    mv $wd/pdkt_kusuma_$i $wd/kenangan/kenangan_$i
  else
    mv $wd/pdkt_kusuma_$i $wd/duplicate/duplicate_$i
  fi
done

cat $wd/wget.log >> $wd/wget.log.bak
rm $wd/wget.log
