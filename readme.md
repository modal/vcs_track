# VCS_TRACK #

## Description ##
**VCS_TRACK** is a set of scripts that generate a c/c++ header file with the current git commit SHA1 and data.

The script should be run as part of the pre-build steps prior to compiling the c/c++ code.

When this commit SHA1 and date are included as const/static item in a c/c++ build, the source information used to generate that particular build can be referenced.

The vcs_track.h file generated should be ignored by a project's version control system.

If the author date is required, instead of the commit date, the git-show script line should be altered.

## Scripts ##
* **vcs_track.sh**
* **vcs_track.py**
* **vcs_track_alt.sh** - Designed for Altera projects fitting a particular
folder structure.

* **vcs_label.py** - Labels Intel Hex Files with git commit date and SHA1.  It is geared towards TI Code Composer projects.

* **show\_alter\_versions.sh** - Displays git metadata for Altera projects fitting a particular folder structure.  Does not write a header file.

## Reference: (Similar Projects and Ideas) ##

[cmakewith-git-metadata](https://github.com/pmirshad/cmake-with-git-metadata)

[How can I get my C code to automatically print out its Git version hash?](http://stackoverflow.com/questions/1704907/how-can-i-get-my-c-code-to-automatically-print-out-its-git-version-hash)

[Xcode: Insert Git Build Info Into iOS App](http://www.egeek.me/2013/02/09/xcode-insert-git-build-info-into-ios-app/)

[git-show](http://git-scm.com/docs/git-show)

[git-rev-parse](http://git-scm.com/docs/git-rev-parse)
