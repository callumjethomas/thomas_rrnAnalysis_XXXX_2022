# Rule
# target : prerequisite1 prerequisite2 prerequisite3
# [tab] recipe
### if target is older than prerequisite(s), run the recipe

code/mothur/mothur.exe : code/install_mothur.sh
	./code/install_mothur.sh

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

data/references/ncbi_names_lookup.tsv data/references/ncbi_nodes_lookup.tsv data/references/ncbi_merged_lookup.tsv : \
			code/get_ncbi_tax_lookup.sh
	./code/get_nacbi_tax_lookup.sh

data/references/genome_id_taxonomy.tsv : code/join_genome_id_taxonomy.R\
			data/raw/rrnDB-5.8.tsv\
			data/references/ncbi_names_lookup\
			data/references/ncbi_nodes_lookup\
			data/references/ncbi_merged_lookup
	./code/join_genome_id_taxonomy.R

data/raw/rrnDB-5.8_16S_rRNA.align : code/align_sequences.sh\
			data/references/silva_seed/silva.seed_v138_1.align\
			data/raw/rrnDB-5.8_16S_rRNA.fasta\
			code/mothur/mothur.exe
	./code/align_sequences.sh

data/%/rrnDB.align data/%/rrnDB.bad.accnos : code/extract_region.sh\
			data/raw/rrnDB-5.8_16S_rRNA.align\
			code/mothur/mothur.exe
	./code/extract_region.sh $@
# % represents a common/repeated pattern

data/%/rrnDB.unique.align data/%/data.count_tibble : code/count_unique.sh\
			code/count_table_to_tibble.R\
			data/%/rrnDB.align\
			code/mothur/mothur
	code/count_unique.sh $@

data/processed/rrnDB.count_tibble : code/combine_count_tibbles.R\
			data/v19/rrnDB.count_tibble\
			data/v4/rrnDB.count_tibble\
			data/v34/rrnDB.count_tibble\
			data/v45/rrnDB.count_tibble
	$^

README.md : README.Rmd
	R -e "library(markdown); render('README.Rmd')"

exploratory/2022-09-30_genome_sens_spec.md :  exploratory/2022-09-30_genome_sens_spec.Rmd\
			data/v19/rrnDB.count_tibble\
			data/v4/rrnDB.count_tibble
	R -e "library(markdown); render('exploratory/2022-09-30_genome_sens_spec.Rmd')"

exploratory/2022-10-05_taxa_representation.md :  exploratory/2022-10-05_taxa_representation.Rmd\
			data/references/genome_id_taxonomy.tsv\
			data/processed/rrnDB.count_tibble
	R -e "library(markdown); render('exploratory/2022-09-30_genome_sens_spec.Rmd')"
