#!/bin/bash
# now it's important to define scripts path
scripts_path='/media/rbnfiles/ruco/repos/bash-scripts/scripts/'
dir=$(pwd)
cd $dir

green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'
user=$USER
diroutput="build-$USER"
# run python script

printf "$green \n Run rename files script...\n\n"


simple_compile()
{
program="/renametotalfiles.py"
python $scripts_path$program    
}


remove_spaces()
{
program="/renametotalfiles.py"
python $scripts_path$program    
}


if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
else
    while getopts "s" option
    do
        case $option in 
            s)
            simple_compile
            ;;
            *)  
            echo "You can select any option"
            exit ;;
        esac
    done
fi