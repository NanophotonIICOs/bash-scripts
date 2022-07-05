import numpy as np
import os
import glob as glob
import sys
from tabulate import tabulate

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

tfiles= []
for files in os.listdir(os.getcwd()):
    if files in files.lower():
        if " " in files:
            print(style.CYAN+'{:<28}'.format(files)+ style.RED+'---> ' + style.YELLOW+'{:>}'.format("This contains spaces, watch out!"))
            print()
        else:
            stra = 'already be lower case!'
            print(style.CYAN+'{:<28}'.format(files)+ style.RED+'---> ' + style.YELLOW+'{:>}'.format(stra))
        pass
    elif " " in files:
        r = files.replace(" ","").lower()
        print(style.CYAN+'{:<28}'.format(files)+ style.RED+'---> ' + style.YELLOW+'{:>}'.format("This contains spaces, watch out!"))
        tfiles.append([files,r.lower()])


if not tfiles:
    print(style.GREEN+"\nAll files already be lower case!")
    print(style.RED+"\nBye...")
    exit
else:
    os.system("echo %s"%(style.YELLOW))    
    print(tabulate(tfiles,headers=["Before name","After name"], tablefmt='orgtbl'))

    response=input(style.RED+"\nThe above files will be rename, you're sure? [Y]/n: ")

    if response=="Y" or response=="y":
        for i in tfiles:
            print(style.MAGENTA+ "Rename: %s"%i[0] + style.WHITE+"--->" + style.BLUE+ "%s:"%i[1])
            os.rename(i[0],i[1])
    else:
        print(style.RED+"\nBye...")
        exit