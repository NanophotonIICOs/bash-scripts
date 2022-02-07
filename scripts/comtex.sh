#!/bin/bash
dir=$(pwd)
cd $dir
green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'

#check if exists tex file
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

# first check if out dir exists
if [ -d "${dir}/out" ] 
then
    echo "$green Directory ${dir}/out exists.$yellow" 
else
    echo "$lcyan Should be create out dir"&&
    mkdir out
fi

simple_compile()
{
    pdflatex -shell-escape -file-line-error -output-directory=out *.tex
}

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
fi

while getopts "bs:f:" option
do
    case $option in 
        b)
            pdflatex -shell-escape -file-line-error -output-directory=out *.tex &&
            echo -e "$lcyan \n\n\n\n\t\t\t Compile BIB \n\n\n\n"
            bibtex out/*.aux &&
            echo -e "\n\n\n"
            pdflatex -shell-escape -file-line-error -output-directory=out *.tex
            ;;
        s)
            echo -e "$lcyan \t\t\t\n\nYou select Makeindex option compile\n\n"
            pdflatex -shell-escape -file-line-error -output-directory=out *.tex &&
            makeglossaries -s out/*.ist -t out/*.glg -o out/*.gls out/*.glo&&
            pdflatex -shell-escape -file-line-error -output-directory=out *.tex
            echo -e "$lcyan \n\n\t\t\t\t${green}Finish\n\n"
            ;;
        f) 
            echo -e "$lcyan \n\n\t\t compile figure from eps\n\n"
            pdflatex -shell-escape -file-line-error -output-directory=out $OPTARG
            ;;
        *)  
            echo "You can select any option"
            exit;;
    esac
done



            