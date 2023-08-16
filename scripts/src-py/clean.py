from click import style
import numpy as np
import os,sys
from tabulate import tabulate
listextensions=[
'*.aux',
'*.lof',
'*.log',
'*.lot',
'*.fls',
'*.out',
'*.toc',
'*.fmt',
'*.fot',
'*.cb',
'*.brf',
'*.mlf',
'*.cb2',
'*.ist',
'*.slo',
'.*.lb',
'*.dvi',
'*.xdv',
'*-converted-to.*',
'*.bbl',
'*.bcf',
'*.blg',
'*-blx.aux',
'*-blx.bib',
'*.run.xml',
'*.fdb_latexmk',
'*.synctex',
'*.synctex(busy)',
'*.synctex.gz',
'*.synctex.gz(busy)',
'*.pdfsync',
'*.alg',
'*.loa',
'acs-*.bib',
'*.thm',
'*.nav',
'*.pre',
'*.snm',
'*.vrb',
'*.soc',
'*.cut',
'*.cpt',
'*.spl',
'*.ent',
'*.lox',
'*.acn',
'*.acr',
'*.glg',
'*.glo',
'*.gls',
'*.glsdefs',
'*.lzo',
'*.lzs',
'*-gnuplottex-*',
'*.gaux',
'*.gtex',
'*.gtex',
'*.idx',
'*.ilg',
'*.ind',
'*.maf',
'*.mlf',
'*.mlt',
'*.mtc[0-9]*',
'*.slf[0-9]*',
'*.slt[0-9]*',
'*.stc[0-9]*',
'*.mtc',
'_minted*',
'*.pyg',
'*.mw',
'*.nlg',
'*.nlo',
'*.nls',
'*.pax',
'*.pdfpc',
'*.sagetex.sage',
'*.sagetex.py',
'*.sagetex.scmd',
'*.wrt',
'*.sout',
'*.sympy',
'*.upa',
'*.upb',
'*.pytxcode',
'pythontex-files-*/',
'*.listing',
'*.loe',
'*.dpth',
'*.md5',
'*.auxlock',
'*.lod',
'*.xcp',
'*.xmpi',
'*.xdy',
'*.xyc',
'*.xyd',
'*.ttt',
'*.fff',
'*.backup',
'.*.swp',
'*~[0-9]*',
'*.tps',
'./auto/*',
'*.el',
'*.sta',
'*.lpz'
]
os.system("")
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
removedfiles=[]
for i in os.listdir(path):
    for j in listextensions:
        if j.split('.')[-1] in i:
            removedfiles.append(['.'+j.split('.')[-1],i])


if not removedfiles:
    print(style.RED+" Doesn't exist extra files to erase.... Bye!")
    exit
else:
    print(style.YELLOW+tabulate(removedfiles,headers=["Extension","File"], numalign="center",tablefmt="orgtbl"))
    response=input(style.RED+"The above files will be deleted, you're sure? [Y]/n: ")
    if response=="Y" or response=="y":
        for i in removedfiles:
            print("Remove %s:"%i[1])
            os.system("rm -R %s"%i[1])
    else:
        exit
