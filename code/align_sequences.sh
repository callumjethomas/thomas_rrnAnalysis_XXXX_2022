#!/usr/bin/env bash

# author: Callum Thomas
# inputs: data/raw/rrnDB-5.8_16S_rRNA.fasta
#         data/references/silva_seed/silva.seed_v138_1.align
# outputs: data/raw/rrnDB-5.8_16S_rRNA.align and logfile.

# NB: We need to include flip=T to ensure all sequences are pointed in the same direction.

code/mothur/mothur.exe '#align.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.fasta, reference=data/references/silva_seed/silva.seed_v138_1.align, flip=T)'
