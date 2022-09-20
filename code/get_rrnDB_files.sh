#!/usr/bin/env bash

# author: Callum Thomas
# inputs: Name of the file to be extracted from the archive (without the path).
# outputs: Appropriate rrnDB version 5.8 file, into data/raw.

target=$1

filename=`echo $target | sed "s/.*\///"`
path=`echo $target | sed -E "s_(.*/).*_\1_"`

curl -kL https://rrndb.umms.med.umich.edu/static/download/"$filename".zip -o "$target".zip
unzip -n -d "$path" "$target".zip
touch "$target"
rm "$target".zip
