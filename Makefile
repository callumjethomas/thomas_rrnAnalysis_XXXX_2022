# Rule
# target : prerequisite1 prerequisite2 prerequisite3
# [tab] recipe
### if target is older than prerequisite(s), run the recipe

data/references/silva_seed/silva.seed_v138_1.align : code/get_silva_seed.sh
	./code/get_silva_seed.sh

data/raw/rrnDB-5.8_16S_rRNA.fasta : code/get_rrnDB_files.sh
	$< $@
# $@ is an automatic variable for the target name!
# $< is an automatic variable for the (first) prerequisite name

data/raw/rrnDB-5.8.tsv : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh $@

data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh $@

data/raw/rrnDB-5.8_pantaxa_stats_RDP.tsv : code/get_rrnDB_files.sh
	./code/get_rrnDB_files.sh $@

data/raw/rrnDB-5.8_16S_rRNA.align : code/align_sequences.sh\
																		data/references/silva_seed/silva.seed_v138_1.align\
																		data/raw/rrnDB-5.8_16S_rRNA.fasta
	./code/align_sequences.sh
