import numpy as np
import os
import sys

# System call
os.system("")

# Class of different styles
class style():
    BLACK = '\033[30m'
    RED = '\033[31m'
    GREEN = '\033[32m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    MAGENTA = '\033[35m'
    CYAN = '\033[36m'
    WHITE = '\033[37m'
    UNDERLINE = '\033[4m'
    RESET = '\033[0m'

path= (sys.argv[1])
count=0
listfiles = []
for i in sorted(os.listdir(path)):
    if i.endswith('.tex'):
        print("%d --->  %s"%(count,i),end='\n\n')
        listfiles.append(i)
        count+=1

while True:
    sfile=input("Select TeX file to compile (number): ")
    try:
        sfile=int(sfile)
        fileselect=(listfiles[sfile])
    except ValueError:
        print(style.RED+'¡Error! you can input a correct number file! 😡')
        continue
    except IndexError:
        print(style.RED+'¡Error! you can input a correct number file! 😡')
        continue
    else:
        print(style.GREEN+"you select: %s 😄"%(fileselect))
        break

diroutput=(sys.argv[2])
type=(sys.argv[3])

for i,j in enumerate(listfiles):
    if i==sfile:
        if type=='lualatex':
            os.system("latexmk -e -lualatex  -pdf -g -shell-escape -outdir=%s %s"%(diroutput,j))
        elif type=='xelatex':
            os.system("latexmk -xelatex -pdf -e  '$max_repeat=2' -g -f -shell-escape  -auxdir=%s -outdir=%s  %s"%(diroutput,diroutput,j))
        elif type=='figure':
            os.system("latexmk -pdflatex -pdf -e  '$max_repeat=1' -g -f -shell-escape  -outdir=%s  %s"%(diroutput,j))
        elif type=='general':
             os.system("latexmk -auxdir=%s -bibtex -pdf -g -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))
        elif type=='revtex':
             os.system("latexmk -auxdir=%s -bibtex -pdf -g -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))
        else:
            os.system("latexmk -auxdir=%s -bibtex -pdf-g  -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))

