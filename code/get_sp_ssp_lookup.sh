#!/usr/bin/env bash

# author: Callum Thomas
# inputs:
# outputs: data/references/sp_ssp_lookup.tsv

curl -kL https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxcat.zip -o data/references/taxcat.zip
unzip -n -d data/references/ data/references/taxcat.zip

# if the last operation was successful, update timestamp
if [[ $? -eq 0 ]]
then
  mv data/references/categories.dmp data/references/sp_ssp_lookup.tsv
  rm data/references/taxcat.zip
else
  echo "ERROR: Unable to successfully extract taxcat.zip."
  exit 1
fi
