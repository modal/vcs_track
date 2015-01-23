import os
import subprocess
##############################################################################
#This script generates a c header with VCS tracking information (commit hash
#and date).
##############################################################################
print "Starting VCS_TRACK"
proc = subprocess.Popen(["git", "rev-parse", "HEAD"], stdout=subprocess.PIPE, shell=True)
#proc = subprocess.Popen(["git", "show", "-s", "--format=%H"], stdout=subprocess.PIPE, shell=True)
(a, err) = proc.communicate()
proc = subprocess.Popen(["git", "show", "-s", "--format=%ci"], stdout=subprocess.PIPE, shell=True)
(b, err) = proc.communicate()
hash_info = a.strip("\n\r")
date_info = b.strip("\n\r")

print "Creating vcs_track.h"
print b, a
f=open("vcs_track.h","w")
f.write("#ifndef __VCS_TRACK_H__\n")
f.write("#define __VCS_TRACK_H__\n")
f.write("//THIS FILE IS AUTO GENERATED\n")
f.write("//DO NOT TRACK THIS FILE WITH THE VCS\n")
f.write("#define VCS_TRACK_DATE " + "\"" + date_info + "\"\n")
f.write("#define VCS_TRACK_HASH " + "\"" + hash_info.upper() + "\"\n")
f.write("#endif")


