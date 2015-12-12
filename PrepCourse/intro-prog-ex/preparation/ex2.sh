#!/bin/sh

# Make sure that it is the current PWD
# This path is unique to my operating system
cd ~/Copy/Tealeaf/PrepCourse/intro-prog-ex/preparation

# Make sure that ex1 has been executed. Overwriting
# any existing content on the files
./ex1.sh

# Delete the created folder and all the files contained
rm -R my_folder
