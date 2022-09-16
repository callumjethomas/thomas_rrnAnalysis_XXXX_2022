Obtained files from the rrnDB located at https://rrndb.umms.med.umich.edu/static/download/.

These are files from v5.8, obtained on 16 September 2022.

For automated downloading tsv file with curl (would be wget on Linux) and unzip:
curl -kL https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8.tsv.zip -o data/raw/rrnDB-5.8.tsv.zip
unzip -n -d data/raw data/raw/rrnDB-5.8.tsv.zip

curl -kL https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_16S_rRNA.fasta.zip -o data/raw/rrnDB-5.8_16S_rRNA.fasta.zip
unzip -n -d data/raw data/raw/rrnDB-5.8_16S_rRNA.fasta.zip

curl -kL https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip -o data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip
unzip -n -d data/raw data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv.zip

curl -kL https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_pantaxa_stats_RDP.tsv.zip -o data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv.zip
unzip -n -d data/raw data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv.zip

