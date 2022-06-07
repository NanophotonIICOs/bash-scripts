import numpy as np
import os
import glob as glob
import sys
from datetime import date

path= (sys.argv[1])
count=0
listfiles = []
print(path)
for i in os.listdir(path):
    if i.endswith('.pdf'):
        print(" %d --->  %s"%(count,i))
        listfiles.append(i)
        count+=1
file = input("Select pdf file to reduce (number): ")
today = date.today()

for i,j in enumerate(listfiles):
     if i==int(file):
         print("%s-%s.pdf"%(j.split('.')[0],today))
         os.system("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -sOutputFile=%s-%s.pdf %s"%(j.split('.')[0],today,j))
         print("Reduce %s ---> %s"%(j,(j.split('.')[0])))
         os.remove(j)

    