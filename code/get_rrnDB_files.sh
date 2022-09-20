#!/usr/bin/env bash

# author: Callum Thomas
# inputs: Name of the file to be extracted from the archive (without the path).
# outputs: Appropriate rrnDB version 5.8 file, into data/raw.

target=$1

filename=`echo $target | sed "s/.*\///"`
path=`echo $target | sed -E "s_(.*/).*_\1_"`

curl -kL https://rrndb.umms.med.umich.edu/static/download/"$filename".zip -o "$target".zip
unzip -n -d "$path" "$target".zip

# if the last operation was successful, update timestamp
if [[ $? -eq 0 ]]
then
  touch "$target"
  rm "$target".zip
else
  echo "ERROR: Unable to successfully extract $filename."
  exit 1
fi
