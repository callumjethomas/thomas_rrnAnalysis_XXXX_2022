#!/usr/bin/env bash

# author: Callum Thomas
# dependencies: data/<region/rrnDB.align
# input:  data/<region>/rrnDB.unique.count_table
#         data/<region>/rrnDB.unique.align
# output: data/<region>/rrnDB.unique.align,
#         data/<region>/rrnDB.unique.count_table

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
  count.seqs(group=$TEMP_GROUPS, compress=FALSE)"

if [[ $? -eq 0 ]]
then
  # Rename files to keep
  mv $STUB_TEMP.unique.align $STUB.unique.align
  mv $STUB_TEMP.count_table $STUB.unique.count_table

  # Garbage collection
  rm $STUB_TEMP.*

else
  echo "ERROR: mothur failed to run properly."
fi
