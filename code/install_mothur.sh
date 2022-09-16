#!/usr/bin/env bash

# author: Callum Thomas
# inputs: none
# outputs: Mothur v.1.48.0 executable files in code/mothur.

curl -kL https://github.com/mothur/mothur/releases/download/v1.48.0/Mothur.win.zip
 -o code/mothur/Mothur.win.zip
unzip -n -d code/mothur code/mothur/Mothur.win.zip
rm code/mothur/Mothur.win.zip
