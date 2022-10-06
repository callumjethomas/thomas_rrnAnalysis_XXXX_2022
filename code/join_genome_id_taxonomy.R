#!/usr/bin/env -S Rscript --vanilla

# name: join_genome_id_taxonomy.R

# input: 
#       - data/raw/rrnDB-5.8.tsv
#       - data/references/sp_ssp_lookup.tsv
#       - data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv
# output: tsv containing: genome id and taxonomic information
#         (data/references/genome_id_taxonomy.tsv)  
# note: 

library(tidyverse)

metadata <- read_tsv("data/raw/rrnDB-5.8.tsv") %>% 
  rename(genome_id = "Data source record id",
         subspecies_id = "NCBI tax id",
         rdp = "RDP taxonomic lineage",
         scientific_name = "NCBI scientific name") %>% 
  select(genome_id, subspecies_id, rdp, scientific_name)

sp_ssp_lookup <- read_tsv("data/references/sp_ssp_lookup.tsv", 
                          col_names = c("domain", "species_id", 
                                        "subspecies_id"))

# Taxids missing species name from sp_ssp_lookup.
makeup_tax <- tibble(taxid = c(639200,
                               1401995,
                               1734031,
                               2795215,
                               2978683),
                     species = c("Sphaerotilus sulfidivorans",
                                 "Clavibacter californiensis",
                                 "Clavibacter phaesoli",
                                 "Brachybacterium halotolerans",
                                 "Burkholderia orbicola"))

tax <- read_tsv("data/raw/rrnDB-5.8_pantaxa_stats_NCBI.tsv") %>% 
  filter(rank == "species") %>% 
  rename(species = "name") %>% 
  select(taxid, species) %>% 
  bind_rows(., makeup_tax)

# Use anti_join to check that there are no taxids with missing species names
test <- inner_join(metadata, sp_ssp_lookup, by="subspecies_id") %>% 
  select(genome_id, species_id, rdp, scientific_name) %>% 
  anti_join(., tax, by = c("species_id" = "taxid")) %>% 
  nrow(.) == 0

stopifnot(test)

inner_join(metadata, sp_ssp_lookup, by="subspecies_id") %>% 
  select(genome_id, species_id, rdp, scientific_name) %>% 
  inner_join(., tax, by = c("species_id" = "taxid")) %>% 
  select(genome_id, rdp, species, scientific_name) %>% 
  filter(!is.na(rdp)) %>% 
# select(-species, -scientific_name) %>%  # remember to remove this!
  mutate(rdp = str_replace(rdp, pattern=".*\\|\\|\\|.*", replacement = "NA|domain")) %>% 
  separate(col=rdp, 
           into=c("rdp_a", "rdp_b", "rdp_c", "rdp_d", 
                  "rdp_e", "rdp_f", "rdp_g", "rdp_h"),
           sep="; ",
           fill="right") %>% 
  pivot_longer(cols=starts_with("rdp_"), names_to = "rank", values_to = "name") %>% 
  filter(!is.na(name)) %>% 
  select(-rank) %>% 
  separate(col=name, into=c("taxon_name", "taxon_rank"), sep="\\|", convert=TRUE) %>% 
  mutate(taxon_name = str_replace_all(taxon_name, pattern=" ", replacement="_")) %>% 
  filter(taxon_rank %in% c("domain", "phylum", "class", "order", "family", "genus")) %>% 
  pivot_wider(names_from="taxon_rank", values_from="taxon_name") %>% 
  write_tsv("data/references/genome_id_rdp_taxonomy.tsv")
  