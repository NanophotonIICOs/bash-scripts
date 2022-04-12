#!/bin/bash
green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'

dir=$(pwd)
cd $dir
imagefiles=`ls -- *.png`
i=0
for f in  $imagefiles; do
    ((i=i+1))

    # to check if already remove image background, this contains wob string
    if [[ ${f%.*} == *"wob"* ]]; then
        echo -e "$red $f Already exist!"
    else
        convert $f -fuzz 10% -transparent White "${f%.*}-wob.png"
        echo -e "$green Remove Background to image  ${f%.*} -- > ${f%.*}-wob.png" 
    fi
done




