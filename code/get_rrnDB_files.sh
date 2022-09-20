#!/usr/bin/env bash

# author: Callum Thomas
# inputs: Name of the file to be extracted from the archive (without the path).
# outputs: Appropriate rrnDB version 5.8 file, into data/raw.

archive=$1

echo "$archive"
curl -kL https://rrndb.umms.med.umich.edu/static/download/"$archive".zip -o data/raw/"$archive".zip
unzip -n -d data/raw data/raw/"$archive".zip
touch data/raw/"$archive"
rm data/raw/"$archive".zip
