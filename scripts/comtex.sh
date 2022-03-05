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
    echo "$green Exists TeX files";
    break
  else
    echo "$red Doesn't exist Tex files"
    exit 0 
  fi
done

# first check if out dir exists
if [ -d "${dir}/out" ] 
then
    echo "$lcyan Directory ${dir}/out exists.$yellow" 
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


#function to reduce size of pdf
reduce_size()
{
  dir=$(pwd)
  cd "$dir/out"
  day=$(date +"%Y-%m-%d")
  for FILE in *.pdf
    do
    if [[ "$1" =~  .*"$FILE".* ]]; then
      echo -e "$green $FILE already reduce!"
    else
      echo -e "$red Reduce: $FILE"
      gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -sOutputFile="${FILE%.*}-$day.pdf"  $FILE
      echo -e "$green Finish!"
      cp "${FILE%.*}-$day.pdf" "../../$FILE"
    fi
  done 
}


while getopts "bsrf:x" option
do
    case $option in 
        b)
        echo "$red";
        pdflatex -shell-escape -file-line-error -output-directory=out *.tex &&
        echo "$lcyan";
        bibtex out/*.aux &&
        echo "$yellow";
        pdflatex -shell-escape -file-line-error -output-directory=out *.tex&&
        echo -e "$green";
        pdflatex -shell-escape -file-line-error -output-directory=out *.tex
        ;;
        s)
        echo -e "$red"
        pdflatex -shell-escape -file-line-error -output-directory=out *.tex &&
        echo -e "$yellow"
        makeglossaries -s out/*.ist -t out/*.glg -o out/*.gls out/*.glo &&
        echo -e "$green"
        pdflatex -shell-escape -file-line-error -output-directory=out *.tex
        ;;
        f) 
        echo -e "$lcyan \n\n\t\t compile figure from eps\n\n"
        pdflatex -shell-escape -file-line-error -output-directory=out $OPTARG
        ;;
        x) 
        xelatex -shell-escape -file-line-error -output-directory=out $OPTARG
        ;;
        r)
        reduce_size
        ;;
        *)  
        echo "You can select any option"
        exit;;
    esac
done

