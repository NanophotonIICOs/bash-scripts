#!/bin/bash

# Paths and colors
scripts_path=$scripts_root
dir=$(pwd)
green='\e[1;32m'
red='\e[0;31m'
blue='\e[0;34m'
lcyan='\e[1;36m'
yellow='\e[1;33m'
endcolor='\e[0m'
user=$USER
diroutput="build-$USER"

# Check if there are .tex files in the current directory
if ls *.tex 1> /dev/null 2>&1; then
  echo -e "${green}Exists TeX files 😁${endcolor}"
else
  echo -e "${red}Doesn't exist TeX files 😡${endcolor}"
  exit 1
fi

# Check if the output directory exists, if not create it
if [ -d "${dir}/$diroutput" ]; then
  echo -e "${lcyan}Directory ${dir}/$diroutput exists.${endcolor}"
else
  echo -e "${lcyan}Creating directory $diroutput${endcolor}"
  mkdir -p "$diroutput"
fi

# Compile functions
simple_compile() {
  local program="/select-TeX-file-latexmk.py"
  local type="general"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_general() {
  local program="/select-TeX-file-latexmk.py"
  local type="general"
  echo  "$green This TeX files are available in this directory"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_figure() {
  echo  "$green Compile figure from: $dir"
  local type="figure"
  local program="/select-TeX-file-latexmk.py"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_lualatex() {
  echo  -e "$lcyan LuaLaTeX"
  local type="lualatex"
  local program="/select-TeX-file-latexmk.py"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_with_xetex() {
  echo  "$lcyan Compile with XeLaTeX"
  local type="xelatex"
  local program="/select-TeX-file-latexmk.py"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_revtex() {
  local program="/select-TeX-file-latexmk.py"
  local type="revtex"
  echo  "$green This TeX files are available in this directory"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

# Function to reduce the size of PDF in build-user dir
reduce_size() {
  local program="reduce-pdf.py"
  cd "${dir}/$diroutput" || exit
  local new_dir=$(pwd)
  python "$scripts_path$program" "$new_dir"
}

remove_background() {
  local program="rmbkgrd.py"
  cd "${dir}/figures" || exit
  local new_dir=$(pwd)
  echo -e "$yellow"
  python "$scripts_path$program" "$new_dir"
}

clean_aux() {
  local program="/clean.py"
  cd "${dir}/$diroutput" || exit
  local new_dir=$(pwd)
  python "$scripts_path$program" "$new_dir"
}

# Main script execution
if [ $# -eq 0 ]; then
  simple_compile # Run usage function
  exit 1
else
  while [[ $# -gt 0 ]]; do
    case $1 in
      -a|--all)
      simple_compile
      shift
      ;;
      -f|--figure)
      compile_figure
      shift
      ;;
      -l|--lualatex)
      compile_lualatex
      shift
      ;;
      -g|--general)
      compile_general
      shift
      ;;
      -c|--clean)
      clean_aux
      shift
      ;;
      -x|--xelatex)
      compile_with_xetex
      shift
      ;;
      -p|--pdfsize)
      reduce_size
      shift
      ;;
      -b|--rembg)
      remove_background
      shift
      ;;
      -r|--revtex)
      compile_revtex
      shift
      ;;
      *)
      echo -e "${red}Invalid option: $1${endcolor}"
      echo "Usage: $0 [-a|--all] [-f|--figure] [-l|--lualatex] [-g|--general] [-c|--clean] [-x|--xelatex] [-p|--pdfsize] [-b|--rembg] [-r|--revtex]"
      exit 1
      ;;
    esac
  done
fi