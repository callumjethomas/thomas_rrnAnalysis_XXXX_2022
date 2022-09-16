#!/usr/bin/env bash

# author: Callum Thomas
# inputs: none
# outputs: Mothur alignment and logfile.

code/mothur/mothur '#align.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.fasta, reference=data/references/silva_seed/silva.seed_v138_1.align, flip=T)'
