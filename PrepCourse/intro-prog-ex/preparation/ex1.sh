#!/bin/sh

# Make sure that it is the current PWD
# This path is unique to my operating system
cd ~/Copy/Tealeaf/PrepCourse/intro-prog-ex/preparation

# Create the my_folder directory
mkdir -v my_folder

# Create the two files and put in contents
echo 'puts "this is file one"' > my_folder/one.rb
echo 'puts "this is file two"' > my_folder/two.rb
