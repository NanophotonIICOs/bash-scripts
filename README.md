# bash-scripts
This repo holds the bash scripts tools used in lflm's research group. The order is next:</br>
- The <mark>comtex.sh</mark> script it's implemented to compile TeX files, it has several options for specific files, for example: if it requires compiling a Tikz figure uses  -f flag with name file as an argument. The default option is -o, this option asked you who file will be compiled, you should enter the file number. 
- The  <mark>remove-kgrd.sh</mark> scripts remove white background from png figures.
- The <mark>rename-files.sh</mark> script rename files in the current dir, but in lowercase.


It's important that you add to your profile (.basrhc, .bash_profile, etc.) and 
add this directory to the PATH. For example:

```sh
PATH=/home/user/bash-scripts/scripts:$PATH; export PATH
export scripts_root="/home/user/bash-scripts/scripts"
```