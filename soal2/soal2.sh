#!/bin/bash
wd=`pwd`
pass="`cat /dev/urandom | tr -cd 'a-zA-Z0-9' | fold -w 28 | head -n 1`"
name="`echo $1 | tr -cd 'a-zA-Z'`"
echo $pass > $wd/$name.txt
namesum="`md5sum $name.txt | cut -d ' ' -f 1`"
echo "$namesum",`date +"%H"` >> $wd/data.csv
