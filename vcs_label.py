import subprocess
import os
import shutil
import sys

"""
This script labels the TI MSP430 Intel Hex Output with the git date and hash.

It is intended to be run standalone or as part of the post build steps after
the hex file has been generated.

The script assumes that it is placed the the project working directory with
a Debug subdirectory.  The Debug subdirectory should contain the output hex
file.

Commandline usage:

    scriptname <basename of hex file>

    basename output.hex ==> output
"""

if len(sys.argv) != 2:
    print "ERROR:  Missing argument for %s" % argv[0]
    sys.exit()

print "Starting VCS_LABEL"
proc = subprocess.Popen(["git", "rev-parse", "HEAD"], stdout=subprocess.PIPE, shell=True)
(a, err) = proc.communicate()
proc = subprocess.Popen(["git", "show", "-s", "--format=%ci"], stdout=subprocess.PIPE, shell=True)
(b, err) = proc.communicate()
hash_info = a.strip("\n\r").upper()
date_info = b.strip("\n\r")
date_info = date_info.split()[0]
date_info = date_info.replace("-", "")

#print hash_info
#print date_info

os.chdir("Debug")
src="%s.hex" % sys.argv[1]
dst="%s%s_%s.hex" % (sys.argv[1], date_info, hash_info)
#os.rename(src, dst)                    #Rename doesn't leave a copy of original file
#shutil.copyfile(src, dst)              #Retains copy, but changes metadata-date
os.system("copy %s %s" % (src, dst))    #Retains metadata-date
