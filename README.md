# bash-scripts
This repo holds the bash scripts tools used in lflm's research group. The order is next:</br>
- The <span style="color:red"><strong>comtex.sh</strong></span> script it's implemented to compile TeX files, it has several options for specific files, for example: if it requires compiling a Tikz figure uses  -f flag with name file as an argument. The default option is -o, this option asked you who file will be compiled, you should enter the file number. 

-  The <span style="color:green"><strong>comtex2.sh</strong></span> is an update of the previous script, this update consider the latexmk to automate TeX compilation. For this command can consider the next flags:
    * **-f** For compilation of graphics, this taken into account of **PGF/TikZ** environment.
    * **-l** For compilation of **lualatex**. 
    * **-x** For compilation of **xelatex**. 

    For this command, there's no need for the file name as an argument, shows the list of **TeX** files for possible compilation, then the user put the number of file. Finally, the script creates a build folder, adding the user name to this <span style="color:blue"><strong>(build-user)</strong></span>.
- The <span style="color:green"><strong>rename-files.sh</strong></span> script rename files in the current dir, but in lowercase.

It's important that you add to your profile (.basrhc, .bash_profile, etc.) the enviroment variables:

```sh
PATH=/path/to/bash-scripts/scripts:$PATH; export PATH
export scripts_root="/path/to/bash-scripts/scripts"
export scripts_utils="/path/to/bash-scripts/scripts/utils"

```
replace that for your PATH.