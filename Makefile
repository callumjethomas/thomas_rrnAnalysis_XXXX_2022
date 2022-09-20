# Rule
# target : prerequisite1 prerequisite2 prerequisite3
# [tab] recipe
### if target is older than prerequisite(s), run the recipe

data/references/silva_seed/silva.seed_v138_1.align : code/get_silva_seed.sh
	./code/get_silva_seed.sh

data/raw/rrnDB-5.8_16S_rRNA.fasta : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh rrnDB-5.8_16S_rRNA.fasta

data/raw/rrnDB-5.8.tsv : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh rrnDB-5.8.tsv

data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh rrnDB-5.8_pantaxa_stats_NCBI.tsv

data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh rrnDB-5.8_pantaxa_stats_RDP.tsv

data/raw/rrnDB-5.8_16S_rRNA.align : data/references/silva_seed/silva.seed_v138_1.align\
																		data/raw/rrnDB-5.8_16S_rRNA.fasta\
																		code/align_sequences.sh
	./code/align_sequences.sh
