import numpy as np
import os
import glob as glob
import sys
from datetime import date

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
print("List of files to reduce")
for i in os.listdir(path):
    if i.endswith('.pdf'):
        print(" %d --->  %s"%(count,i))
        listfiles.append(i)
        count+=1

file = input("Select pdf file to reduce (number): ")
today = date.today()

cpath = os.getcwd()
listpaths=["/".join(cpath.split('/')[:i]) if i!=0 else "/".join(cpath.split('/')[:])   
for i in range(0,-4,-1)]

for i,j in enumerate(listpaths):
    print("%s ---> %s"%(i,j))

while(True):
    cdir=input("Select dir to copy reduce pdf file: ")
    try:
        cdircomplete=listpaths[int(cdir)]
    except IndexError:
        print(style.RED+'¡Error! you can input a correct number file! ')
        continue
    except ValueError:
        print(style.RED+'¡Error! you can input a correct number file! ')
        continue
    else:
        print("you select: %s"%(cdircomplete))
        break



for i,j in enumerate(listfiles):
     if i==int(file):
         print("%s-%s.pdf"%(j.split('.')[0],today))
         compath=cdircomplete+"/"+j.split('.')[0]+"-"+str(today)+".pdf"
         os.system("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -sOutputFile=%s %s"%(compath,j))
         print("Reduce %s ---> %s"%(j,compath))
         os.remove(j)

    