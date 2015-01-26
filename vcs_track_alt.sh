#!/bin/bash

##############################################################################
#VCS Track Altera Project Git Commit Metadata
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

dircnt=0

label_arr=()
hash_arr=()
date_arr=()

function export_meta_data {
    tp=$(basename `pwd`)
    tpc=$(echo $tp | awk '{print toupper($0)}') #Capitalize ==> assume Bash 3
    echo -e "${green}$1 ${tp}$endColor"
    hash=$(git rev-parse HEAD)
    date=$(git show -s --format=%ci)
    echo $hash
    echo $date
    echo -e "#define VCS_TRACK_HASH_$1_$tpc \"$hash\"" >> $2
    echo -e "#define VCS_TRACK_DATE_$1_$tpc \"$date\"" >> $2
    label_arr[dircnt]="$1_$tpc"
    hash_arr[dircnt]=$hash
    date_arr[dircnt]=$date
    ((dircnt++))
}

timestamp=$(date +"%Y/%m/%d %H:%M:%S")
basedir=$(pwd)
f="$basedir/vcs_track.h"

echo \#ifndef __VCS_TRACK_H__ > $f
echo \#define __VCS_TRACK_H__ >> $f
echo \/\/THIS FILE IS AUTO GENERATED >> $f
echo \/\/DO NOT TRACK THIS FILE WITH THE VCS/SCM >> $f
echo \/\/$timestamp >> $f

echo -e "${green}${tp}$endColor"
export_meta_data SW $f

cd ../../
fpgadir=$(pwd)
export_meta_data HW $f

echo -e "${red}Altera Avalon IP$endColor"
cd ip
ipdir=$(pwd)
for i in $(ls -1d */); do
    cd $i
    #Only print git details if folder contains a .git folder
    if [ -d .git ]; then
        export_meta_data IP $f
    fi
    cd ..
done;

echo >> $f
echo -e "#define VCS_TRACK_COUNT $dircnt" >> $f

#for x in ${hash_arr[@]}; do
#   echo $x
#done

printf "\ntypedef struct VCS_TRACK_BUF_TYPE_STRUCT {\n" >> $f
printf "    char *hash;\n" >> $f
printf "    char *date;\n" >> $f
printf "    char *label;\n" >> $f
printf "} VCS_TRACK_BUF_TYPE;\n\n" >> $f

echo "static VCS_TRACK_BUF_TYPE vcs_track_buffer[VCS_TRACK_COUNT] = {"  >> $f


last_index=$(expr ${#hash_arr[@]} - 1)
for((i=0; i < ${#hash_arr[@]}; i++)); do
    printf "    {\"${hash_arr[$i]}\", \"${date_arr[$i]}\", \"${label_arr[$i]}\"}" >> $f
    if [ $i -eq $last_index ]; then
        printf "\n" >> $f
    else
        printf ",\n" >> $f
    fi
done
echo -e "};" >> $f

echo \#endif >> $f

cd $basedir
