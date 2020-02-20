#!/bin/bash
wd=`pwd`
a=`awk -F "\t" 'NR > 1 {seen[$13]+=$NF} END{for (i in seen) printf "%s,%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "," -k 2 | awk -F "," 'NR < 2 {printf "%s\n", $1}'`
echo -e "Region yang paling sedikit profitnya adalah $a"
b=`awk -F "\t" -v a=$a '{if (match($13, a)) seen[$11]+=$NF} END {for (i in seen) printf "%s,%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t  "," -k 2 | awk -F "," 'NR < 3 {printf "%s\n", $1}'`
echo -e "\nStates yang paling rendah profitnya dari region $a =\n$b"

s1=`echo $b | awk -F " " '{printf "%s", $1}'`
s2=`echo $b | awk -F " " '{printf "%s", $2}'`

c1=`awk -F "\t" -v s1=$s1 '{if (match($11, s1)) seen[$17]+=$NF} END {for (i in seen) printf "%s?%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "?" -k 2 | awk -F "?" 'NR < 11 {printf "%s, %f\n", $1, $2}'`
c2=`awk -F "\t" -v s2=$s2 '{if (match($11, s2)) seen[$17]+=$NF} END {for (i in seen) printf "%s?%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "?" -k 2 | awk -F "?" 'NR < 11 {printf "%s, %f\n", $1, $2}'`

c3=`awk -F "\t" -v s1=$s1 -v s2=$s2 '{if (match($11, s1)||match($11, s2)) seen[$17]+=$NF} END {for (i in seen) printf "%s?%f\n", i, seen[i]}' $wd/Sample-Superstore.tsv | sort -g -t "?" -k 2 | awk -F "?" 'NR < 11 {printf "%s, %f\n", $1, $2}'`

echo -e "\n10 Produk yang paling rendah profitnya dari state $s1 =\n$c1"
echo -e "\n10 Produk yang paling rendah profitnya dari state $s2 =\n$c2"

echo -e "\n10 Produk yang paling rendah proftnya dari gabungan state $s1 dan $s2 =\n$c3"
