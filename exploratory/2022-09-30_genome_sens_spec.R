library(tidyverse)

### For the full length of the gene (v1-9)

fl <- read_tsv("data/v19/rrnDB.count_tibble")

# How many rrn copies are in each genome?
fl %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count)) %>%
  ggplot(aes(x = n_rrn)) + geom_histogram(binwidth = 1)

# How many genomes had each number of rrn copies?
fl %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count)) %>%
  count(n_rrn) %>% 
  mutate(fraction = n/sum(n))

# What is the number of ASVs per genome?
fl %>%
  group_by(genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  group_by(n_rrn) %>% 
  summarise(med_n_asv = median(n_asv),
            lq_n_asv = quantile(n_asv, prob=0.25),
            uq_n_asv = quantile(n_asv, prob = 0.75))

fl %>%
  group_by(genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  ggplot(aes(x = n_rrn, y = n_asv)) + geom_smooth(method = "lm")

# How many genomes does each ASV appear in?
fl %>% 
  group_by(asv) %>% 
  summarise(n_genome = n()) %>% 
  count(n_genome) %>% 
  mutate(fraction = n/sum(n))


#### What about for V4?

v4 <- read_tsv("data/v4/rrnDB.count_tibble")

# How many rrn copies are in each genome?
v4 %>%
  group_by(genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  group_by(n_rrn) %>% 
  summarise(mean_n_asv = mean(n_asv),
            lq_n_asv = quantile(n_asv, prob=0.25),
            uq_n_asv = quantile(n_asv, prob = 0.75))

# How many genomes had each number of rrn copies?
v4 %>%
  group_by(genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count)) %>% 
  ggplot(aes(x = n_rrn, y = n_asv)) + geom_smooth(method = "lm")

# How many genomes does each ASV appear in?
v4 %>% 
  group_by(asv) %>% 
  summarise(n_genome = n()) %>% 
  count(n_genome) %>% 
  mutate(fraction = n/sum(n))
