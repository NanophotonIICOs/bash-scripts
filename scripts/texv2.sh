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

diroutput="build-$USER"
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

# first check if $diroutput dir exists
if [ -d "${dir}/$diroutput" ] 
then
    echo "$lcyan Directory ${dir}/$diroutput exists.$yellow" 
else
    echo "$lcyan Should be create $diroutput dir"&&
    mkdir $diroutput
fi

# compile functions 
simple_compile()
{
    latexmk -auxdir=$diroutput -bibtex -pdf -shell-escape -outdir=$diroutput -diagnostics
}


compile_option()
{
  program="/choice-TeX-file-latexmk.py"
  echo "$green This TeX files are availables in this directory"
  python $scripts_path$program $dir $diroutput

}

compile_figure()
{
    echo -e "$lcyan \n\n\t\t compile figure from \n\n"
    pdflatex -shell-escape -file-line-error -output-directory=$diroutput $OPTARG
  
}

compile_with_xetex()
{
  xelatex -shell-escape -file-line-error -output-directory=$diroutput $OPTARG
}

compile_revtex()
{
  pdflatex -shell-escape -file-line-error *.tex
  bibtex  *.tex
  pdflatex -shell-escape -file-line-error *.tex
}



#function to reduce size of pdf in build-user dir
reduce_size()
{
  program="reduce-pdf.py"
  cd "${dir}/$diroutput"
  new_dir=$(pwd)
  python $scripts_path$program $new_dir
}

clean_aux()
{
  code="clean.py"
  dir=$(pwd)
  cd "${dir}/$diroutput" 
  new_dir=$(pwd)
  python $scripts_path$code $new_dir 
}

# after each compilation, it's removed auxiliary files, if you don't need this, uses -a flag

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
else
    while getopts "aoc" option
    do
        case $option in 
            a)
            simple_compile 
            ;;
            o)
            compile_option 
            ;;
            c)
            clean_aux
            ;;
            *)  
            echo "You can select any option"
            exit;;
        esac
    done

fi