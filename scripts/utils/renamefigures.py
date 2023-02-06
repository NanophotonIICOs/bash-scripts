from logging import warning
import numpy as np
import os
import glob as glob
import sys
import warnings

fext=input("Put figures extension (png,pdf,jpeg,jpg, etc.): ")
name=input("Put name of the serie of figures: ")

count=0
for files in sorted(os.listdir(os.getcwd())):
    if (fext=='png' and files.endswith('.png')):
        print("%s ---> %s-%d"%(files,name,count))
        os.rename(files,"%s-%d.png"%(name,count))
        count+=1
    
    elif (fext=='pdf' and files.endswith('.pdf')):
        print("%s ---> %s-%d"%(files,name,count))
        os.rename(files,"%s-%d.pdf"%(name,count))
        count+=1

    elif (fext=='jpeg' and files.endswith('.jpeg')):
        print("%s ---> %s-%d"%(files,name,count))
        os.rename(files,"%s-%d.jpeg"%(name,count))
        count+=1
    
    elif (fext=='jpg' and files.endswith('.jpg')):
        print("%s ---> %s-%d"%(files,name,count))
        os.rename(files,"%s-%d.jpg"%(name,count))
        count+=1
    else:
        try:
            print("Try with an exsitent image extension")
            exit 
        except (RuntimeError, TypeError, NameError):
            pass