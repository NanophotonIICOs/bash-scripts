import numpy as np
import os
import sys
from tabulate import tabulate
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
listfilestable = []
listfiles = []

for i in sorted(os.listdir(path)):
    if i.endswith('.tex'):
        #print("%d --->  %s"%(count,i),end='\n')
        listfilestable.append([count,i])
        listfiles.append(i)
        count+=1

columns = ["No. File", "File Name"]
print(tabulate(listfilestable, headers=columns, numalign="center",tablefmt="orgtbl"))
        
while True:
    sfile=input(style.GREEN+"\nSelect TeX file to compile (number): ")
    try:
        sfile=int(sfile)
        fileselect=(listfiles[sfile])
    except ValueError:
        print(style.RED+'¡Error! You should input a correct number! 😡')
        continue
    except IndexError:
        print(style.RED+'¡Error! You should input a correct number! 😡')
        continue
    else:
        print(style.GREEN+"You select: %s 😄"%(fileselect))
        break

diroutput=(sys.argv[2])
type=(sys.argv[3])

for i,j in enumerate(listfiles):
    if i==sfile:
        if type=='lualatex':
            os.system("latexmk  -lualatex -auxdir=%s -e -pdf -g -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))
        elif type=='xelatex':
            os.system("latexmk -xelatex -pdf -e  '$max_repeat=2' -g -f -shell-escape  -auxdir=%s -outdir=%s  %s"%(diroutput,diroutput,j))
        elif type=='figure':
            os.system("echo  '\033[37m'")
            os.system("latexmk -shell-escape -pdflatex -pdf   -g -f -auxdir=%s  -outdir=%s  %s"%(diroutput,diroutput,j))
        elif type=='general':
             os.system("latexmk -auxdir=%s -bibtex -pdf -g -f -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))
        elif type=='revtex':
             os.system("latexmk -auxdir=%s -bibtex -pdf -g -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))
        if type=='asy':
            os.system("latexmk  -pdf -g -f -auxdir=%s  -outdir=%s %s"%(diroutput,diroutput,j))
        else:
            os.system("latexmk -auxdir=%s -bibtex -pdf -g -f -shell-escape -outdir=%s %s"%(diroutput,diroutput,j))

