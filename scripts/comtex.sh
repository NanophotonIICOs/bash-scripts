#!/bin/bash
dir=$(pwd)
cd $dir


#check if exists tex file
if [ -e *.tex ]; then
  echo "Exists TeX files"
else
  echo "Doesn't exist Tex files"
  exit 0
fi
# first check if out dir exists
if [ -d "${dir}/out" ] 
then
    echo "Directory ${dir}/out exists." 
else
    echo "Should be create out dir"&&
    mkdir out
fi


simple_compile()
{
    pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out *.tex
}

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
fi

green=$(tput setaf 2)            

while getopts "bs:f:" option
do
    case $option in 
        b)
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out *.tex &&
            echo -e "\n\n\n\n\t\t\t Compile BIB \n\n\n\n"
            bibtex out/*.aux &&
            echo -e "\n\n\n"
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out *.tex
            ;;
        s)
            echo -e "\t\t\t\n\nYou select Makeindex option compile\n\n"
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out *.tex &&
            makeglossaries -s out/*.ist -t out/*.glg -o out/*.gls out/*.glo&&
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out *.tex
            echo -e "\n\n\t\t\t\t${green}Finish\n\n"
            ;;
        f) 
            echo -e "\n\n\t\t compile figure from eps\n\n"
            pdflatex -synctex=1 -shell-escape -output-directory=out $OPTARG
            #convert out/$OPTARG.pdf -fuzz 10% -transparent White out/$OPTARG.pdf
            ;;
        *)  
            simple_compile
            exit;;
    esac
done



            