#!/bin/bash
wd=`pwd`

choose() { echo ${1:RANDOM%${#1}:1} $RANDOM; }
pass="$({
for i in $0
do
  choose '0123456789'
  choose 'abcdefghijklmnopqrstuvwxyz'
  choose 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
done
}| sort -R | awk '{printf "%s" ,$1}' | cut -d " " -f 2 | fold -w 28 | head -n 1)"

name="`echo $1 | tr -cd 'a-zA-Z'`"
echo $pass > $wd/$name.txt
namesum="`md5sum $name.txt | cut -d ' ' -f 1`"
echo "$namesum",`date +"%H"` >> $wd/data.csv
