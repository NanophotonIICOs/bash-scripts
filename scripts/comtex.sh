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


# compile functions 

simple_compile()
{
    pdflatex -shell-escape -file-line-error -output-directory=out *.tex
}

compile_figure()
{
    echo -e "$lcyan \n\n\t\t compile figure from \n\n"
    pdflatex -shell-escape -file-line-error -output-directory=out $OPTARG
  
}

compile_figure_robust()
{
  echo -e "$lcyan \n\n\t\t compile figure with lualatex \n\n"
  lualatex -shell-escape -file-line-error -output-directory=out $OPTARG
}

compile_with_index()
{
  echo -e "$red"
  pdflatex -shell-escape -file-line-error -output-directory=out *.tex &&
  echo -e "$yellow"
  makeglossaries -s out/*.ist -t out/*.glg -o out/*.gls out/*.glo &&
  echo -e "$green"
  pdflatex -shell-escape -file-line-error -output-directory=out *.tex
}

compile_with_bib()
{
  echo "$red";
  pdflatex -shell-escape -file-line-error -output-directory=out *.tex &&
  echo "$lcyan";
  bibtex out/*.aux &&
  echo "$yellow";
  pdflatex -shell-escape -file-line-error -output-directory=out *.tex&&
  echo -e "$green";
  pdflatex -shell-escape -file-line-error -output-directory=out *.tex
}

compile_with_xetex()
{
  xelatex -shell-escape -file-line-error -output-directory=out $OPTARG
}


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

clean_aux()
{
  dir=$(pwd)
  cd "$dir/out" 
  for auxfiles in * 
  do
    if [[ $auxfiles != *.pdf ]]; then
      echo -e "Delete:$auxfiles"
      rm -R $auxfiles
    fi
  done 
}



if [ $# -eq 0 ]; then
    simple_compile # run usage function
    clean_aux
    exit 1
else
    while getopts "bsrf:xt:cl:" option
    do
        case $option in 
            b)
            compile_with_bib
            clean_aux
            ;;
            s)
            compile_with_index
            clean_aux
            ;;
            f) 
            compile_figure
            clean_aux
            ;;
            x) 
            compile_with_xetex
            clean_aux
            ;;
            r)
            reduce_size
            clean_aux
            ;;
            c)
            clean_aux
            ;;
            l) 
            compile_figure_robust
            clean_aux
            ;;
            *)  
            clean_aux
            echo "You can select any option"
            exit;;
        esac
    done

fi