#!/usr/bin/env bash

# author: Callum Thomas
# dependencies: data/raw/rrnDB-5.6_16S_rRNA.align
# input: target name (the output location) in format data/<region>/rrnDB.align

filename=$1

region=`echo "$filename" | sed -E "s_.*/(.*)/.*_\1_"`
path=`echo "$filename" | sed -E "s_(.*/.*)/.*_\1_"`

if [[ "$region" = v19 ]]
then
  start=1044
  end=43116
elif [[ "$region" = v4 ]]
then
  start=13862
  end=23444
elif [[ "$region" = v34 ]]
then
  start=6428
  end=23444
elif [[ "$region" = v45] ]]
then
  start=13862
  end=27659
else
  echo "ERROR: We don't have coordinates for $region."
  exit 1
fi

echo "region: $region"
echo "start: $start"
echo "end: $end"
mkdir -p $path

code/mothur/mothur.exe "#pcr.seqs(fasta=data/raw/rrnDB-5.8_16S_rRNA.align, start=$start, end=$end, outputdir=$path); filter.seqs(vertical=TRUE)"

# if mothur runs successfully, touch the files that might not be generated
# in pcr.seqs because the seqs spanned desired region's coordinates
if [[ $? -eq 0 ]]
then
  touch $path/rrnDB-5.8_16S_rRNA.bad.accnos
  touch $path/rrnDB-5.8_16S_rRNA.scrap.pcr.align
else
  echo "ERROR: Mothur failed to run."
  exit 1
fi

# clean up file names
mv $path/rrnDB-5.8_16S_rRNA.pcr.filter.fasta $filename
mv $path/rrnDB-5.8_16S_rRNA.bad.accnos $path/rrnDB.bad.accnos

# garbage collection
rm $path/rrnDB-5.8_16S_rRNA.pcr.align
rm $path/rrnDB-5.8_16S_rRNA.scrap.pcr.align
rm $path/rrnDB-5.filter
