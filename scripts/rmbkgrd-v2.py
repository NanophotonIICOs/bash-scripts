from asyncio import subprocess
import numpy as np 
from PIL import Image
import sys
import os
import subprocess

# try:
#     from rembg import remove
# except ImportError as e:
#     pass  # module doesn't exist, deal with it.

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

# check if tools environment is activate
actual_env=actual_env=os.environ['CONDA_DEFAULT_ENV']
if actual_env =='base':
    print(style.RED+'It is necessary to activate tools environment, bye')
    exit
else:
    pass



