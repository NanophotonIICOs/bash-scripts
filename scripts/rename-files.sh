#!/bin/bash
# now it's important to define scripts path
scripts_path='/media/labfiles/ruco/repos/bash-scripts/scripts/'


green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'
user=$USER
diroutput="build-$USER"
# run python script

printf "$green \nRun rename files script...\n\n"

code="/renamef.py"
python $scripts_path$code