#!/usr/bin/env ruby

Files = [ '.zshrc', '.zlogout', '.nanorc', '.vimrc' ]
Dirs  = [ 'bin', '.vim' ]

# Iterate over each file
#   Doesn't exist in the system? Copy!
#   Identical? Skip
#   Local file newer than system?  Copy!
#   Otherwise, meld
#
# Iterate over each directory
#   Iterate over each file in each directory
#     Create parent directory, if necessary
#     Same process as above files
