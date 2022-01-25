#!/bin/bash
dir=$(pwd)
cd $dir

imagefiles=`ls -- *.png`
i=0
for f in  $imagefiles; do
    ((i=i+1))
    #convert $f -transparent white -fuzz 10% "F${i}.png"
    convert $f -fuzz 10% -transparent White "exout-${i}.png"
    echo "Remove Background to image $f -- > exout-${i}.png"
done




