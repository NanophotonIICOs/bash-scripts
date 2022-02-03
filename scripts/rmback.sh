#!/bin/bash
dir=$(pwd)
cd $dir
filelist=$(ls *.eps)
green=$'\e[1;32m'


for file in $filelist
do
    if [[ "$file" =~  .*"$1".* ]]; then
        convert $file -fuzz %5 -transparent White "${file%.*}-out.pdf"
        echo "$green $file ---> ${file%.*}-out.pdf"
    fi
done


