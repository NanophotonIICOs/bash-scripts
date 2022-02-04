#!/bin/bash
dir=$(pwd)
cd $dir


if [ -e *.tex ]; then
  echo "Exists TeX files"
else
  echo "Doesn't exist Tex files"
  exit 0
fi

# first check if out folder exists
if [ -d "${dir}/out" ] 
then
    echo "Directory ${dir}/out exists." 
else
    echo "Error: Directory ${dir}/out-ruco does not exists."
fi
