from lib2to3.pytree import convert
from matplotlib import image
import numpy as np
import os,sys
from sympy import im
from tabulate import tabulate
# System call
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

imextlist=['.png','.jpeg','jpg','.pdf']
path= (sys.argv[1])
ctype=(sys.argv[2])


def images(path):
    imfiles=[]
    count=0
    countim=0
    for i,image in enumerate(sorted(os.listdir(path))):
        if 'wob' in image:
            pass
        else:
            if image.endswith('.gif'):
                imfiles.append([count,image])
                count+=1
    imfiles=sorted(imfiles)
    print(tabulate(imfiles,headers=["No. image","Image name"],numalign="center",tablefmt="orgtbl"))
    return imfiles


imfiles=images(path)
while True:
    imsel=input(style.YELLOW+"Select a image file (number): ")
    try:
        imsel=int(imsel)
        imageselect=(imfiles[imsel][1])
    except ValueError:
        print(style.RED+'¡Error! You should input a correct number! 😡')
        continue
    except IndexError:
        print(style.RED+'¡Error! You should input a correct number! 😡')
        continue
    else:
        print(style.GREEN+"You select: %s 😄"%(imageselect))
        break


imext = imageselect.split('.')[-1]
imname =  imageselect.split('.')[0]
if ctype=="png":
    outdirname=imname+'-out'
    if os.path.exists(outdirname) :
        print ("The path already exist...")
    else:
        os.system("mkdir %s"%(outdirname))
        print(style.MAGENTA+'%s was created!'%(outdirname))
 
while os.WIFSIGNALED:
    print(style.BLUE+'Converting....')
    try:
        if ctype =="png":
            os.system("convert %s  \
                    -coalesce      \
                    -quality 100   \
                    -fuzz 20%% -transparent white \
                    %s/%s.png"%(imageselect,outdirname,imname)) 
        else:
            os.system("convert %s -coalesce   -fuzz 20%% -transparent white %s.pdf"%(imageselect,imname)) 
    except ValueError:
        print(style.RED+"Error!")
        break
    else:
        print(style.GREEN+'\n Finish!')
        break

