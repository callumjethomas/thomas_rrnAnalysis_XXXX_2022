#!/usr/bin/env bash

# author: Callum Thomas
# inputs: data/raw/rrnDB-5.8_16S_rRNA.fasta
#         data/references/silva_seed/silva.seed_v138_1.align
# outputs: data/raw/rrnDB-5.8_16S_rRNA.align and logfile.

# NB: We need to include flip=T to ensure all sequences are pointed in the same direction.

# Replace all (g) spaces in headers with underscores to prevent mothur truncating headers after space.
sed "s/ /_/g" data/raw/rrnDB-5.8_16S_rRNA.fasta > data/raw/rrnDB-5.8_16S_rRNA.temp.fasta

code/mothur/mothur.exe '#align.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.temp.fasta, reference=data/references/silva_seed/silva.seed_v138_1.align, flip=T)'

if [[ $? -eq 0 ]]
then
  mv data/raw/rrnDB-5.8_16S_rRNA.temp.align data/raw/rrnDB-5.8_16S_rRNA.align
  rm data/raw/rrnDB-5.8_16S_rRNA.temp.fasta
else
  echo "ERROR: mothur failed to align the sequences."
fi
