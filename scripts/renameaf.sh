#!/bin/bash
green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'

dir=$(pwd)
cd $dir

echo "$lcyan The list of image files is: $endcolor"
for file in *.*; 
do  
    echo "$yellow $file"
done


counter=0

while :
    do
        echo -n "$red Enter the name of all images: "
        read name
        if [ -z "$name" ] 
        then 
            echo -n "$red Enter the name of all images: "
            read name
        else
            for file in *.*;
            do

                extension="${file##*.}"
                echo "$lcyan ${name}-$counter.$extension"
                mv "$file" "${name}-$counter.$extension"
                counter=$((counter+1))
            done
            break
        fi
    done







# simple_name()
# {
#     dir=$(pwd)
#     cd $dir
#     for file *.j
# }

# gif_compile()
# {
#     dir=$(pwd)
#     cd $dir
#     program="rmbkgrd-g.py"
#     python $scripts_path$program  $dir
# }

# if [ $# -eq 0 ]; then
#     simple_compile # run usage function
#     exit 1
# else
#     while getopts "gp" option
#     do
#         case $option in 
#             g)
#             gif_compile 
#             ;;
#             *)  
#             echo "You can select any option"
#             exit ;;
#         esac
#     done
# fi