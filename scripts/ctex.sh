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
  local type="simple"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_option() {
  local program="/select-TeX-file-latexmk.py"
  local type="general"
  echo -e "$green This TeX files are available in this directory"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_figure() {
  echo -e "$green Compile figure from: $dir"
  local type="figure"
  local program="/select-TeX-file-latexmk.py"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_lualatex() {
  echo -e "$lcyan LuaLaTeX"
  local type="lualatex"
  local program="/select-TeX-file-latexmk.py"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_with_xetex() {
  echo -e "$lcyan Compile with XeLaTeX"
  local type="xelatex"
  local program="/select-TeX-file-latexmk.py"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

compile_revtex() {
  local program="/select-TeX-file-latexmk.py"
  local type="revtex"
  echo -e "$green This TeX files are available in this directory"
  python "$scripts_path$program" "$dir" "$diroutput" "$type"
}

# Function to reduce the size of PDF in build-user dir
reduce_size() {
  local program="reduce-pdf.py"
  cd "${dir}/$diroutput" || exit
  local new_dir=$(pwd)
  echo -e "$yellow"
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
  while getopts "aoclxpfr" option; do
    case $option in
      a) simple_compile ;;
      f) compile_figure ;;
      l) compile_lualatex ;;
      o) compile_option ;;
      c) clean_aux ;;
      x) compile_with_xetex ;;
      p) reduce_size ;;
      b) remove_background ;;
      r) compile_revtex ;;
      *) echo "Invalid option. Use -a, -o, -c, -l, -x, -p, -f, -r, -b."
         exit 1 ;;
    esac
  done
fi