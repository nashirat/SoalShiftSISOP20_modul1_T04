#!/bin/bash
wd=`pwd`

name="${1%.*}"
namesum="`md5sum $1 | cut -d ' ' -f 1`"
key=`awk -v ns=$namesum -F "," '{if (match($1, ns))print$2}' $wd/data.csv`
ds=$(echo {a..z} | sed -r 's/ //g')
dc=$(echo $ds | sed -r "s/^.{$key}//g")$(echo $ds | sed -r "s/.{$( expr 26 - $key )}$//g")
de=`echo $name | tr '[A-Z]' $ds | tr $dc $ds`

mv $wd/$name.txt $wd/$de.txt
