#!/usr/bin/env -S Rscript --vanilla

# name: combine_count_tibbles.R

# input: tidy versions (tibbles) of data for each gene region
# output: composite tidy count file with ID column designating the region
# note: input files need to be in the format "data/<region>/rrnDB.count_tibble"

library(tidyverse)

tibble_files <- commandArgs(trailingOnly=TRUE)

# Assign names to each vector element.

names(tibble_files) <- str_replace(string=tibble_files,
                                   pattern="data/(.*)/rrnDB.count_tibble",
                                   replacement="\\1")

# Apply function (.f) to each element of vector (.x), return a data frame 
# bound by row (dfr) plus the name of each vector element (.id) as an ID.

map_dfr(.x=tibble_files, .f=read_tsv, .id="region") %>% 
  write_tsv("data/processed/rrnDB.count_tibble")

