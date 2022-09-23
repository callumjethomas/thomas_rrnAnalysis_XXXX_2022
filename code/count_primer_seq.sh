#!/usr/bin/env bash

# author: Callum Thomas
# dependencies: none
# input: region alignment named in format data/<region>/rrnDB.align
#        primer region of interest (V3 or V4)
# output: list of sequences containing primer (rrnDB.ambigs.align)

# Get all the non-header lines and then count the number of lines that contain
# the primer sequence of interest.

input=$1
primer=$2

if [[ $primer = "V3" ]]
then
  primerseq="C-*C-*T-*A-*C-*G-*G-*G-*A-*G-*G-*C-*A-*G-*C-*A-*G"
elif [[ $primer = "V4" ]]
then
  primerseq="G-*T-*G-*C-*C-*A-*G-*C-*[AC]-*G-*C-*C-*G-*C-*G-*G-*T-*A-*A"
else
  echo "ERROR: We don't have a primer stored for that region."
fi

grep -v "^>" $1 | grep -c $primerseq
