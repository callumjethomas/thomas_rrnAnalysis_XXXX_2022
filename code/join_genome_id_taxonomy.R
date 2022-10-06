#!/usr/bin/env -S Rscript --vanilla

# name: join_genome_id_taxonomy.R

# input: 
#       - data/raw/rrnDB-5.8.tsv
#       - data/references/ncbi_merged_lookup.tsv
#       - data/references/ncbi_names_lookup.tsv
#       - data/references/ncbi_nodes_lookup.tsv
# output: tsv containing: genome id and taxonomic information
#         (data/references/genome_id_taxonomy.tsv)  
# note: get col_names for TSVs from data/references/readme.txt

library(tidyverse)


merged <- read_delim("data/references/ncbi_merged_lookup.tsv", delim="|",
                     trim_ws=T, col_names=c("old_tax_id", "new_tax_id"))

metadata <- read_tsv("data/raw/rrnDB-5.8.tsv") %>% 
  rename(genome_id = "Data source record id",
         tax_id = "NCBI tax id",
         rdp = "RDP taxonomic lineage",
         scientific_name = "NCBI scientific name") %>% 
  filter(!is.na(rdp)) %>% 
  select(genome_id, tax_id, scientific_name) %>% 
  left_join(., merged, by=c("tax_id" = "old_tax_id")) %>% 
  mutate(tax_id = ifelse(!is.na(new_tax_id), new_tax_id, tax_id)) %>% 
  select(-new_tax_id, -X3)

nodes <- read_delim("data/references/ncbi_nodes_lookup.tsv", delim="|",
                    trim_ws=T, col_names=c("tax_id", "parent_tax_id", "rank",
                      "embl_code", "division_id", "inherited_div_flag",
                      "genetic_code_id", "inherited_GC_flag",
                      "mitochondrial_genetic_code_id", "inherited_MGC_flag",
                      "GenBank_hidden_flag", "hidden_subtree_root_flag",
                      "comments")) %>% 
  select(tax_id, parent_tax_id, rank)

names <- read_delim("data/references/ncbi_names_lookup.tsv", delim="|",
                    trim_ws=T, col_names=c("tax_id", "name_txt", "unique_name", 
                                           "name_class")) %>% 
  filter(name_class == "scientific name") %>% 
  select(tax_id, name_txt)

tree <- inner_join(nodes, metadata, by="tax_id") %>% 
  unite(tr_a, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_b, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_c, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_d, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_e, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_f, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_g, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_h, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_i, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_j, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_k, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id")) %>% 
  unite(tr_l, tax_id, rank, sep="_") %>% 
  inner_join(nodes, ., by=c("tax_id" = "parent_tax_id"))

test1 <- tree %>% 
  count(parent_tax_id) %>% 
  nrow()
stopifnot(test1 == 1)

test2 <- tree %>% 
  anti_join(metadata, tree, by="genome_id") %>% 
  nrow()
stopifnot(test2 == 0)

tree %>% 
  select(-parent_tax_id) %>% 
  pivot_longer(cols=starts_with("tr_"), names_to="tr", values_to="id_rank") %>% 
  select(-tr) %>% 
  separate(id_rank, into=c("tax_id", "rank"), sep="_", convert=T) %>% 
  filter(rank %in% c("superkingdom", "phylum", "class", 
                     "order", "family", "genus", "species")) %>% 
  inner_join(., names, by="tax_id") %>% 
  select(-tax_id) %>% 
  pivot_wider(names_from="rank", values_from="name_txt") %>% 
  rename(kingdom = "superkingdom") %>% 
  select(genome_id, scientific_name, kingdom, phylum, 
         class, order, family, genus, species) %>% 
  write_tsv("data/references/genome_id_taxonomy.tsv")
