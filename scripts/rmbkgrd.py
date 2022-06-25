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

def images(path):
    imfiles=[]
    count=0
    countim=0
    for i,image in enumerate(sorted(os.listdir(path))):
        if 'wob' in image:
            pass
        else:
            if image.endswith('.png'):
                imfiles.append([count,image])
                count+=1
            elif image.endswith('.jpg'):
                imfiles.append([count,image])
                count+=1
            elif image.endswith('jpeg'):
                imfiles.append([count,image]) 
                count+=1
            elif image.endswith('.pdf'):
                imfiles.append([count,image])
                count+=1
            else:
                countim+=1
                print(style.RED+"Exist %d images with not consider extension 🚫"%(countim))
    imfiles=sorted(imfiles)
    print(tabulate(imfiles,headers=["No. image","Image name"],numalign="center",tablefmt="orgtbl"))
    return imfiles


imextlist=['.png','.jpeg','jpg','.pdf']
path= (sys.argv[1])
while True:
    select = input(style.CYAN+'Press 1 to remove the background for a specific image in this dir or press 2 if you want to remove all  images background: ')
    try:
        sel=int(select)
        if sel == 1 or sel == 2:
            print(style.GREEN+"Ok 😄")  
            break
    except ValueError:
        print(style.RED+'¡Error! You should input a correct number! 😡')
        continue
    except IndexError:
        print(style.RED+'¡Error! You should input a correct number! 😡')
        continue 
    else:
        print(style.GREEN+"You select: %s 😄"%(select))
        break

if sel==2:
    imfiles=images(path)
    conti1 = input(style.YELLOW+"For all above images will remove white background, you're sure? [Y/n]:")
    if conti1=="Y" or conti1=="y":
        while os.WIFSIGNALED:
            print(style.BLUE+'Converting....')
            try:
                for i in imfiles:
                    imext = i[1].split('.')[-1]
                    imname =  i[1].split('.')[0]
                    os.system("convert %s -fuzz 10 -transparent White %s.%s"%(i[1],imname,imext)) 
                    print(style.YELLOW+"%s"%(i[1]),end="\r")
            except ValueError:
                print(style.RED+"Error!")
                break
            else:
                print(style.GREEN+'Finish!')
                break
    else:
        exit

elif sel==1:
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
    while os.WIFSIGNALED:
        print(style.BLUE+'Converting....')
        try:
            os.system("convert %s -fuzz 10 -transparent White %s.%s"%(imageselect,imname,imext)) 
        except ValueError:
            print(style.RED+"Error!")
            break
        else:
            print(style.GREEN+'\n Finish!')
            break