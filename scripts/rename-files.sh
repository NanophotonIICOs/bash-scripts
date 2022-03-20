#!/bin/bash


# now it's important to define scripts path
python /media/labfiles/ruco/repos/bash-scripts/scripts/renamef.py  >> files.txt
filename=files.txt
n=1
while read line; do
    echo "$line" 
    n=$((n+1))
done < $filename

rm -R files.txt
