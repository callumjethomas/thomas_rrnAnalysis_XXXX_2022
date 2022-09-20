#!/usr/bin/env bash

# author: Callum Thomas
# inputs: none
# outputs: places SILVA SEED ref. alignment into data/references/silva_seed

# Automate retreiving SILVA SEED reference sequence to help aligning our
# sequence data. Get version 138.1. Because .tgz file contains a README file,
# we extract to subdirectory 'silva_seed' to not overwrite existing README.

curl -kL https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138_1.tgz -o data/references/silva.seed_v138_1.tgz
mkdir data/references/silva_seed
tar xvzmf data/references/silva.seed_v138_1.tgz -C data/references/silva_seed
rm data/references/silva.seed_v138_1.tgz
