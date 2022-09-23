#!/usr/bin/env bash

# author: Callum Thomas
# dependencies: none
# input: region alignment named in format data/<region>/rrnDB.align
# output: csv file of the headers of each entry in the alignment fasta file,
#         with the first entry being column labels for each field


input=$1
path=`echo "$1" | sed -E "s_(.*/.*)/.*_\1_"`
headers="organism, genome_accession, sequence_accession, chromosome, genome_coordinates"

# Get all headers from input alignment, remove >, replace | with , and export

echo "$headers" > "$path"/header_table.csv

# some organism names contain commas (,) which will mess up our csv
# need to replace existing commas in names with periods (.)

grep ">" "$input" | sed "s/>//"| sed "s/,/./g" | sed "s/|/, /g" >> "$path"/header_table.csv
