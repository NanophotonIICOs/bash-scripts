#!/bin/bash
#!/bin/python
scripts_path='/media/labfiles/ruco/repos/bash-scripts/scripts/'
dir=$(pwd)
cd $dir
green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'
scripts_path=$scripts_root
program="/choice-file.py"
dirname="build-"

#check if exists tex file
for file in ./*.tex
do 
  if [ -f "${file}" ]; then
    echo "$green Exists TeX files :)";
    break
  else
    echo "$red Doesn't exist Tex files"
    exit 0 
  fi
done

# first check if build dir exists
if [ -d "${dir}/${dirname}${USER}" ] 
    then
        echo "$green Directory ${dir}/${dirname}${USER} exists.$endcolor" 
    else
        echo -n "Dou you can create a ${dirname}${USER} directory? [Y/n] "
        read perm
        if [ $perm = 'y' ] || [ $perm = 'Y' ]; then
            echo "$yellow Should be create ${dirname}${USER} dir"&&
            mkdir ${dirname}${USER}
        else
          exit 0
        fi
fi


# while getopts 'abcdef' option; do
#     case "$option" in
#     a)
#         python $scripts_path$program $option
#     ;;
#     b)
#         python $scripts_path$program $option
#     ;;
#     c)
#         python $scripts_path$program $option
#     ;;
#     ?)
#       echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
#       exit 1
#       ;;
#   esac
# done
# shift "$(($OPTIND -1))"
