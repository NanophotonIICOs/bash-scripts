#!/bin/bash
dir=$(pwd)
cd $dir

usage()
{
    echo "You select simple option compile"
    pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
}

while getopts "bs:" option;do
    case $option in 
        b)
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex &&
            echo -e "\n\n\n\n\t\t\t Compile BIB \n\n\n\n"
            bibtex out-ruco/*.aux &&
            echo -e "\n\n\n"
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
            ;;
        s)
            echo -e "You select Makeindex option compile\n\n"
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
            makeglossaries  -s  out-ruco/*.ist -t out-ruco/*.glg -o out-ruco/*.gls out-ruco/*.glo
            pdflatex -synctex=1 -interaction=nonstopmode -output-directory=out-ruco *.tex
            ;;
        *)  
            usage
            exit;;
    esac
done



            