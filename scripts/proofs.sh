#!/bin/bash
dir=$(pwd)
cd $dir


# first check if out folder exists
if [ -d "${dir}/out-ruco" ] 
then
    echo "Directory ${dir}/out-ruco exists." 
else
    echo "Error: Directory ${dir}/out-ruco does not exists."
fi
