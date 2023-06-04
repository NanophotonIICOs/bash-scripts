#!/bin/bash
green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'

scripts_path='/media/rbnfiles/ruco/repos/bash-scripts/scripts/utils/'

simple_compile()
{
    dir=$(pwd)
    cd $dir
    program="rmbkgrd.py"
    python $scripts_path$program $dir
}

gif_compile()
{
    dir=$(pwd)
    cd $dir
    program="rmbkgrd-g.py"
    type="pdf"
    python $scripts_path$program  $dir $type
}
gif_to_png()
{
    dir=$(pwd)
    cd $dir
    type="png"
    program="rmbkgrd-g.py"
    python $scripts_path$program  $dir $type
}

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
else
    while getopts "gp" option
    do
        case $option in 
            g)
            gif_compile 
            ;;
            p)
            gif_to_png
            ;;
            *)  
            echo "You can select any option"
            exit ;;
        esac
    done
fi