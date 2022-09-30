#!/usr/bin/env -S Rscript --vanilla

# name: count_table_to_tibble.R

# input: mothur-formatted count file (full)
# output: tidy data frame with asv, genome, count as columns
# note: we expect args to be in order: input, output

library(tidyverse)

args=commandArgs(trailingOnly=TRUE)

input_file <- args[1]
output_file <- args[2]

print("Importing TSV file.")
print("...")
bigfile <- read_tsv(input_file) %>%
  rename(asv=Representative_Sequence) %>%
  select(-total)
print("File imported.\n")

print("Splitting TSV file into quarters to reduce memory usage:")
quarter <- as.integer((nrow(bigfile))/4)
bigfile_1_4 <- bigfile[1:quarter,]
print("First quarter.")
bigfile_2_4 <- bigfile[(quarter+1):(quarter*2),]
print("Second quarter.")
bigfile_3_4 <- bigfile[((quarter*2)+1):(quarter*3),]
print("Third quarter.")
bigfile_4_4 <- bigfile[((quarter*3)+1):(quarter*4),]
print("Fourth quarter.")
bigfile_last <- bigfile[-(1:(quarter*4)),]
print("Remainder.\n")

rm(bigfile)

print("Pivoting and filtering quarters:")
bigfile_1_4 <- bigfile_1_4 %>%
  pivot_longer(cols=-asv, names_to="genome", values_to="count") %>%
  filter(count != 0)
print("First quarter.")

bigfile_2_4 <- bigfile_2_4 %>%
  pivot_longer(cols=-asv, names_to="genome", values_to="count") %>%
  filter(count != 0)
print("Second quarter.")

bigfile_3_4 <- bigfile_3_4 %>%
  pivot_longer(cols=-asv, names_to="genome", values_to="count") %>%
  filter(count != 0)
  print("Third quarter.")

bigfile_4_4 <- bigfile_4_4 %>%
  pivot_longer(cols=-asv, names_to="genome", values_to="count") %>%
  filter(count != 0)
  print("Fourth quarter.")

bigfile_last <- bigfile_last %>%
  pivot_longer(cols=-asv, names_to="genome", values_to="count") %>%
  filter(count != 0)
  print("Remainder.\n")

print("Binding resulting tibbles back together.\n")
bigfile <- rbind(bigfile_1_4, bigfile_2_4, bigfile_3_4, bigfile_4_4, bigfile_last)

bigfile <- bigfile %>%
  write_tsv(output_file)

print(paste("Final tibble output to:", output_file))
