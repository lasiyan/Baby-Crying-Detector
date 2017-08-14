#!C:\Users\Mystes\Desktop\BCD_Project\Scripts\python.exe
# EASY-INSTALL-ENTRY-SCRIPT: 'cython==0.26','console_scripts','cygdb'
__requires__ = 'cython==0.26'
import re
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(
        load_entry_point('cython==0.26', 'console_scripts', 'cygdb')()
    )
