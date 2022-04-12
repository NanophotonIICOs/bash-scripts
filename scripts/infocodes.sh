#!/bin/bash

green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor="\e[0m"

echo -e "$green \t\t\t Welcome to Bash Scripts LFLM labs \n$endcolor"
echo -e "$yellow These codes it's composed by :$endcolor\\n "

printf "$blue comtex.sh: $endcolor\\n \\t\\t This code compiles from single pdfLaTeX to luaLaTeX with complex figures and also Asymptote.
\\t\\t To use this code you need to run it into the PATH of TeX file, if you compile a Figure you need
\\t\\t to use the  -f flag followed by the file name.  \n\n"

printf "$blue remove-bkgrd.sh: $endcolor \\n \\t\\t This code removes the white background in PNG images, and only needs to run into the PATH. \n\n"