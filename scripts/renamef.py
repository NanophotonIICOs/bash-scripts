import numpy as np
import os
import glob as glob
import sys


files = glob.glob('*')

for files in os.listdir(os.getcwd()):
    if files in files.lower():
         print("Already lower name directory!")
    elif files != "__pycache__":
        os.rename(files,files.lower())
        print("%s ---to---> %s "%(files,files.lower()))

