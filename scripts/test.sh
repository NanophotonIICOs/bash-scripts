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
scripts_path=$scripts_root
program="/choice-file.py"


while getopts 'abcdef' option; do
    case "$option" in

    a)
        python $scripts_path$program $option
    ;;
    b)
        python $scripts_path$program $option
    ;;
    c)
        python $scripts_path$program $option
    ;;
     ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
