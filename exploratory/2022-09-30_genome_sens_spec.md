Analysing the sensitivity and specificity of ASVs for discriminating
between genomes
================
Callum Thomas
2022-09-30

``` r
library(tidyverse)
library(here)
library(scales)
```

### Need to determine the number of *rrn* operons across genomes.

``` r
count_tibble <- read_tsv(here("data/processed/rrnDB.count_tibble"),
                         col_types = "cccd")
```

How many rrn copies are in each genome for the full-length sequences
(v1-9)?

``` r
count_tibble %>% 
  filter(region == "v19") %>%
  group_by(genome) %>% 
  summarise(n_rrn = sum(count), .groups="drop") %>%
  ggplot(aes(x = n_rrn)) + geom_histogram(binwidth = 1)
```

![](2022-09-30_genome_sens_spec_files/figure-gfm/n_rrn-1.png)<!-- -->

What do these numbers look like as a fraction of all genomes?

``` r
count_tibble %>% 
  filter(region == "v19") %>% 
  group_by(genome) %>% 
  summarise(n_rrn = sum(count), .groups="drop") %>%
  count(n_rrn) %>% 
  mutate(fraction = n/sum(n))
```

    ## # A tibble: 21 × 3
    ##    n_rrn     n fraction
    ##    <dbl> <int>    <dbl>
    ##  1     1  2367   0.0860
    ##  2     2  2961   0.108 
    ##  3     3  3165   0.115 
    ##  4     4  3051   0.111 
    ##  5     5  2109   0.0766
    ##  6     6  3903   0.142 
    ##  7     7  5082   0.185 
    ##  8     8  2552   0.0927
    ##  9     9   647   0.0235
    ## 10    10   653   0.0237
    ## # … with 11 more rows

We see that most genomes actually have more than one copy of the *rrn*
operon. I wonder if those different copies are the same sequence/ASV?

### What is the number of ASVs per genome?

Considering that most genomes have multiple copies of the *rrn* operon,
we need to know whether they all have the same ASV. Otherwise, we run
the risk of splitting a single genome into multiple ASVs.

``` r
count_tibble %>% 
  group_by(region, genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count), .groups="drop") %>% 
  group_by(region, n_rrn) %>% 
  summarise(med_n_asv = median(n_asv),
            mean_n_asv = mean(n_asv),
            lq_n_asv = quantile(n_asv, prob=0.25),
            uq_n_asv = quantile(n_asv, prob = 0.75))
```

    ## # A tibble: 84 × 6
    ## # Groups:   region [4]
    ##    region n_rrn med_n_asv mean_n_asv lq_n_asv uq_n_asv
    ##    <chr>  <dbl>     <dbl>      <dbl>    <dbl>    <dbl>
    ##  1 v19        1         1       1           1        1
    ##  2 v19        2         1       1.28        1        2
    ##  3 v19        3         1       1.40        1        2
    ##  4 v19        4         1       1.82        1        2
    ##  5 v19        5         3       2.71        1        4
    ##  6 v19        6         2       2.76        1        4
    ##  7 v19        7         4       4.25        3        6
    ##  8 v19        8         5       4.72        3        7
    ##  9 v19        9         7       6.31        5        8
    ## 10 v19       10         7       6.25        4        9
    ## # … with 74 more rows

``` r
count_tibble %>%
  group_by(region, genome) %>% 
  summarise(n_asv = n(), n_rrn = sum(count), .groups="drop") %>% 
  ggplot(aes(x = n_rrn, y = n_asv, color = region)) + geom_smooth(method = "lm")
```

![](2022-09-30_genome_sens_spec_files/figure-gfm/n_ASV-1.png)<!-- -->

Surprisingly, the number of ASVs increases at a rate of about 2 ASVs per
3 copies of the *rrn* operon in the genome for the full-length sequence.
The sub- regions of the gene have fewer ASVs per *rrn* operon.

### How many genomes does each ASV appear in?

Are ASVs unique to genomes they are found in?

``` r
(ASV_per_genome <- count_tibble %>% 
  group_by(region, asv) %>% 
  summarise(n_genome = n()) %>% 
  count(n_genome) %>% 
  mutate(fraction = n/sum(n)) %>% 
  filter(n_genome == 1))
```

    ## # A tibble: 4 × 4
    ## # Groups:   region [4]
    ##   region n_genome     n fraction
    ##   <chr>     <int> <int>    <dbl>
    ## 1 v19           1 32421    0.826
    ## 2 v34           1 11718    0.780
    ## 3 v4            1  7165    0.751
    ## 4 v45           1  9423    0.779

We see that (for full-length sequences) 82.56 % of ASVs were unique to a
genome. For the sub-regions, the percentage of ASVs was lower: 78% for
region 3-4, 75.14% for region 4 and 77.95% for region 4-5.

#### To be determined:

-   Can we correct for overrepresentation?
-   Consider analysis at species, genus, family, etc. levels?
-   Consider more broad definition of an ASV
