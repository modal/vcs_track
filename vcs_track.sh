#!/bin/bash

##############################################################################
f="vcs_track.h"
echo Creating vcs_track.h
hash=$(git rev-parse HEAD)
date=$(git show -s --format=%ci)

echo \#ifndef __VCS_TRACK_H__ > $f
echo \#define __VCS_TRACK_H__ >> $f
echo \/\/THIS FILE IS AUTO GENERATED >> $f
echo \/\/DO NOT TRACK THIS FILE WITH THE VCS >> $f
echo \#define VCS_TRACK_DATE \"$hash\" >> $f
echo \#define VCS_TRACK_HASH \"$date\" >> $f

echo \#endif >> $f

##############################################################################
#Future
#Get SW commit data
#Get HW commit data
#Get HW/IP commit data  ==> Recursively and generate a super string?
