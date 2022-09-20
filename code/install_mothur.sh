#!/usr/bin/env bash

# author: Callum Thomas
# inputs: none
# outputs: Mothur v.1.48.0 executable files in code/mothur.

curl -kL https://github.com/mothur/mothur/releases/download/v1.48.0/Mothur.win.zip -o code/Mothur.win.zip
unzip -n -d code code/Mothur.win.zip
rm code/Mothur.win.zip

# if install successful, update folder timestamp
if [[ $? -eq 0 ]]
then
  touch code/mothur/mothur
else
  echo "ERROR: Unable to succesfully install mothur."
  exit 1
fi
