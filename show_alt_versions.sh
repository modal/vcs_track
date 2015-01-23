#!/bin/bash

##############################################################################
#Display Altera Project Git Commit Metadata
#
#Assumes this is run out of a folder contained with in a workspace folder that
#is in a FPGA design project folder.
#
#   Firmware folder
#   /FPGA_FOLDER/WORKSPACE/FIRMWARE_PROJECT
#
#   FPGA project folder
#   /FPGA_FOLDER/
#
#   Altera IP folder
#   /FPGA_FOLDER/ip
#
##############################################################################
red='\e[0;31m'
mag='\e[0;35m'
green='\e[0;32m'
endColor='\e[0m'
##############################################################################

tp=$(basename `pwd`)
echo -e "${green}FIRMWARE ${tp}$endColor"
git rev-parse HEAD
git show -s --format=%ci

cd ../../
tp=$(basename `pwd`)
echo -e "${green}FPGA ${tp}$endColor"
git rev-parse HEAD
git show -s --format=%ci

echo -e "${red}Altera Avalon IP$endColor"
cd ip
for i in $(ls -1d */); do
    cd $i
    #Only print git details if folder contains a .git folder
    if [ -d .git ]; then
        tp=$(basename `pwd`)
        echo -e "${green}${tp}$endColor"
        git rev-parse HEAD
        git show -s --format=%ci
    fi
    cd ..
done;
