green=$'\e[1;32m'
red=$'\e[0;31m'
blue=$'\e[0;34m'
lcyan=$'\e[1;36m'
yellow=$'\e[1;33m'
endcolor=$'\e[0m'

simple_compile()
{
    program="rmbkgrd-v2.py"
    python $scripts_path$program
}

if [ $# -eq 0 ]; then
    simple_compile # run usage function
    exit 1
else
    while getopts "gp" option
    do
        case $option in 
            g)
            gif_compile 
            ;;
            p)
            gif_to_png
            ;;
            *)  
            echo "You can select any option"
            exit ;;
        esac
    done
fi