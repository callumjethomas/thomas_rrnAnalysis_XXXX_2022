#!/usr/bin/env bash

# name: count_unique.sh
# Takes in fasta file, gets unique sequences and counts them. Then converts the
# count table to a tidy data format (tibble).

# author: Callum Thomas
# dependencies: code/mothur/mothur.exe
#               code/count_table_to_tibble.R
# input:  target - either the count_tibble or align file
# output: target - either the count_tibble or align file

TARGET=$1
STUB=`echo $TARGET | sed -E "s/(.*rrnDB).*/\1/"`
STUB_TEMP=$STUB.temp

ALIGN=$STUB.align
TEMP_ALIGN=$STUB_TEMP.align
TEMP_GROUPS=$STUB_TEMP.groups

# Extract fields 2,3 and 5 from the fasta headers (separated by |)
sed -E "s/>.*\|(.*)\|(.*)\|.*\|(.*)_.$/>\1\|\2\|\3/" $ALIGN > $TEMP_ALIGN

# Extract new headers from temp file and get all three fields (first set of
# parentheses and also first field by itself (second set of parentheses)
grep ">" $TEMP_ALIGN | sed -E "s/>((.*)\|.*\|.*)/\1 \2/" > $TEMP_GROUPS

code/mothur/mothur.exe "#unique.seqs(fasta=$TEMP_ALIGN, format=name);
  count.seqs(group=$TEMP_GROUPS);
  count.seqs(count=$STUB_TEMP.count_table, compress=false)"

if [[ $? -eq 0 ]]
then

  # Convert full count table to tidy format.
  code/count_table_to_tibble.R $STUB_TEMP.full.count_table $STUB.count_tibble
  echo "Count tibble created."

  # Rename files to keep
  mv $STUB_TEMP.unique.align $STUB.unique.align

  # Garbage collection
  rm $STUB_TEMP.*

else
  echo "ERROR: mothur failed to run properly."
fi
