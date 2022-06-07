import numpy as np
import os
import sys

path= (sys.argv[1])
count=0
listfiles = []
for i in sorted(os.listdir(path)):
    if i.endswith('.tex'):
        print(" %d --->  %s"%(count,i))
        listfiles.append(i)
        count+=1
file = input("Select TeX file to compile (number): ")

diroutput=(sys.argv[2])
for i,j in enumerate(listfiles):
    if i==int(file):
        os.system("pdflatex -shell-escape -file-line-error -output-directory=%s %s"%(diroutput,j))
        os.system("bibtex %s/*.aux"%(diroutput))
        os.system("pdflatex -shell-escape -file-line-error -output-directory=%s %s"%(diroutput,j))