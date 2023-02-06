#!/bin/bash
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

#check if exists tex file
for file in ./*.tex
do 
  if [ -f "${file}" ]; then
    emoji='😁'
    echo -e "$green Exists TeX files ${emoji} $endcolor";
    break
  else
  emoji='😁'
    echo "$red Doesn't exist Tex files $emoji $endcolor"
    exit 0 
  fi
done

# first check if $diroutput dir exists
if [ -d "${dir}/$diroutput" ] 
then
    echo "$lcyan Directory ${dir}/$diroutput exists.${endcolor}" 
else
    echo "$lcyan Should be create $diroutput dir"&&
    mkdir -m 777 $diroutput
fi

# compile functions 
simple_compile()
{
  program="/choice-TeX-file-latexmk.py"
  type="simple"
  python $scripts_root$program $dir $diroutput $type
}

compile_option()
{
  program="/choice-TeX-file-latexmk.py"
  type="general"
  echo "$green This TeX files are availables in this directory"
  python $scripts_root$program $dir $diroutput $type
}

compile_figure()
{
  program="/choice-TeX-file-latexmk.py"
  type="figure"
  python $scripts_root$program $dir $diroutput $type
}

compile_lualatex()
{
  program="/choice-TeX-file-latexmk.py"
  type="lualatex"
  python $scripts_root$program $dir $diroutput $type
}

compile_with_xetex()
{
 echo -e "$lcyan \n\n\t\t compile figure from \n"
    type="xelatex"
    program="/choice-TeX-file-latexmk.py"
    python $scripts_root$program $dir $diroutput $type
}

compile_revtex()
{
 program="/choice-TeX-file-latexmk.py"
  type="revtex"
  echo "$green This TeX files are availables in this directory"
  python $scripts_root$program $dir $diroutput $type
}

#function to reduce size of pdf in build-user dir
reduce_size()
{
  program="reduce-pdf.py"
  cd "${dir}/$diroutput"
  new_dir=$(pwd)
  echo -e "$yellow"
  python $scripts_root$program $new_dir
}

remove_background()
{
  program="rmbkgrd.py"
  cd "${dir}/figures"
  new_dir=$(pwd)
  echo -e "$yellow"
  python $scripts_root$program $new_dir
}

clean_aux()
{
  code="clean.py"
  dir=$(pwd)
  cd "${dir}/$diroutput" 
  new_dir=$(pwd)
  python $scripts_root$code $new_dir 
}

compile_asy()
{
  program="/choice-TeX-file-latexmk.py"
  type="asy"
  echo "$green This TeX files are availables in this directory"
  python $scripts_root$program $dir $diroutput $type
}

# after each compilation, it's removed auxiliary files, if you don't need this, uses -a flag

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
else
    while getopts "aoclxpfry" option
    do
        case $option in 
            a)
            compile_asy 
            ;;
            b)
            remove_background
            ;;
            c)
            clean_aux
            ;;
            f)
            compile_figure 
            ;;
            l)
            compile_lualatex
            ;;
            o)
            compile_option 
            ;;
            x)
            compile_with_xetex
            ;;
            p)
            reduce_size
            ;;
            r)
            compile_revtex
            ;;
            s)
            simple_compile
            ;;
            *)  
            echo "You can select any option"
            exit ;;
        esac
    done
fi