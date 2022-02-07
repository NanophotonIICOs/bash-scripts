#!/bin/bash
dir=$(pwd)
cd $dir

for file in ./*.tex
do 
  if [ -f "${file}" ]; then
    echo "Exists TeX files";
    break
  else
    echo "Doesn't exist Tex files"
    exit 0 
  fi
done


# first check if out folder exists
if [ -d "${dir}/out" ] 
then
    echo "Directory ${dir}/out exists." 
else
    echo "Error: Directory ${dir}/out-ruco does not exists."
fi
