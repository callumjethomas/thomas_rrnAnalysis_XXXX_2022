#!/usr/bin/env bash

# author: Callum Thomas
# dependencies: none
# input: region alignment named in format data/<region>/rrnDB.align
# output: list of sequences containing ambiguous bases (rrnDB.ambigs.align)

# Get all the non-header lines and then count the number of these that contain Ns

input=$1
grep -v "^>" $1 | grep -c "N"
