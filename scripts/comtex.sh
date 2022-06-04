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

user=$USER
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

# first check if out dir exists
if [ -d "${dir}/build-$user" ] 
then
    echo "$lcyan Directory ${dir}/build-$user exists.$yellow" 
else
    echo "$lcyan Should be create build-$user dir"&&
    mkdir build-$user
fi

# compile functions 
simple_compile()
{
    pdflatex -shell-escape -file-line-error -output-directory=out *.tex
}

compile_all()
{
  for file in *.tex
    do
    echo "$file"
    pdflatex -shell-escape -file-line-error -output-directory=out $file
    echo "$lcyan";
    bibtex out/*.aux 
    pdflatex -shell-escape -file-line-error -output-directory=out $file
    pdflatex -shell-escape -file-line-error -output-directory=out $file
  
  done
}

compile_option()
{
  program="/choice-TeX-file.py"
  echo "$green This TeX files are availables in this directory"
  python $scripts_path$program $dir

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



compile_revtex()
{
  pdflatex -shell-escape -file-line-error *.tex
  bibtex  *.tex
  pdflatex -shell-escape -file-line-error *.tex
}



#function to reduce size of pdf
reduce_size()
{
  program="reduce-pdf.py"
  cd "${dir}/build-$user"
  new_dir=$(pwd)
  python $scripts_path$program $new_dir
}

clean_aux()
{
  code="clean.py"
  dir=$(pwd)
  cd "${dir}/build-$user" 
  new_dir=$(pwd)
  python $scripts_path$code $new_dir 
}

# after each compilation, it's removed auxiliary files, if you don't need this, uses -a flag

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
else
    while getopts "anbsrf:x:t:cl:op" option
    do
        case $option in 
            a)
            simple_compile 
            ;;
            n)
            compile_all
            ;;
            b)
            compile_with_bib
            ;;
            s)
            compile_with_index
            ;;
            f) 
            compile_figure
            ;;
            x) 
            compile_with_xetex
            ;;
            r)
            compile_revtex
            ;;
            c)
            clean_aux
            ;;
            l) 
            compile_figure_robust
            ;;
            o) 
            compile_option
            ;;
            p) 
            reduce_size
            ;;
            *)  
            echo "You can select any option"
            exit;;
        esac
    done

fi