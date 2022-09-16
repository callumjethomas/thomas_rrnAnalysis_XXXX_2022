# README

File downloaded [SILVA v138 SEED reference files](https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138_1.tgz) from [mothur wiki](https://mothur.org/wiki/silva_reference_files) on 16 September 2022.

Used `curl`, `mkdir` and `tar` to download and extract SILVA SEED reference files to `data/references/silva_seed`:

```
curl -kL https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138_1.tgz -o data/references/silva.seed_v138_1.tgz
mkdir data/references/silva_seed
tar xvzf data/references/silva.seed_v138_1.tgz -C data/references/silva_seed
```
