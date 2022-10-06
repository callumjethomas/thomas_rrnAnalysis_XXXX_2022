#!/usr/bin/env bash

# author: Callum Thomas
# inputs:
# outputs: data/references/ncbi_names_lookup.tsv
#          data/references/ncbi_nodes_lookup.tsv
#          data/references/ncbi_merged_lookup.tsv

curl -kL https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdmp.zip -o data/references/taxdmp.zip
unzip -n -d data/references/ data/references/taxdmp.zip

# if the last operation was successful, update timestamp
if [[ $? -eq 0 ]]
then
  mv data/references/names.dmp data/references/ncbi_names_lookup.tsv
  mv data/references/nodes.dmp data/references/ncbi_nodes_lookup.tsv
  mv data/references/merged.dmp data/references/ncbi_merged_lookup.tsv
  touch data/references/ncbi_*_lookup.tsv
  rm data/references/taxdmp.zip
  rm data/references/*.dmp
  rm data/references/gc.prt
else
  echo "ERROR: Unable to successfully extract taxdmp.zip."
  exit 1
fi
