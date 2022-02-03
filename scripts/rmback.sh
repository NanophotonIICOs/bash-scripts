#!/bin/bash
dir=$(pwd)
cd $dir
green=$(tput setaf 2)            
while getopts "p:e:" option
do
    case $option in 
        p)
            for fig in $OPTARG;
            do
                 convert $fig -fuzz %5 -transparent White "${fig%.*}-out.pdf"
                 echo -e "${green}$fig ---> ${fig%.*}-out.pdf"
            done
            ;;
        *)  
            exit;;
    esac
done


