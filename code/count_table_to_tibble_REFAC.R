#!/usr/bin/env -S Rscript --vanilla

# name: count_table_to_tibble.R

# input: mothur-formatted count file (full)
# output: tidy data frame with asv, genome, count as columns
# note: we expect args to be in order: input, output

library(tidyverse)
library(data.table)

#args=commandArgs(trailingOnly=TRUE)

#input_file <- args[1]
#output_file <- args[2]

input_file <- "data/v19/rrnDB.temp.full.count_table"
output_file <- "data/v19/rrnDB.count_tibble"

print("Importing TSV file.")

profvis(
  fread(input_file) %>%
    rename(asv=Representative_Sequence) %>%
    select(-total) %>%
    melt(id.vars="asv", variable.name="genome", value.name="count") %>%
    filter(count != 0) %>%
    write_tsv(output_file)
)

print(paste("Final tibble output to:", output_file))
