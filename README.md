Code Club Project: Assessing whether intra- and inter-genomic variation
hinder utility of ASVs.
================
Callum Thomas
2022-10-04

Developed over a series of *Code Club* episodes led by Pat Schloss
([Riffomonas](https://www.youtube.com/c/RiffomonasProject)) to answer an
important question in microbiology and become comfortable using tools to
develop reproducible research practices.

### Dependencies:

-   `mothur`
    [v.1.48.0](https://github.com/mothur/mothur/releases/tag/v1.48.0),
    `code/install_mothur.sh` installs mothur.
-   R version 4.2.0 (2022-04-22 ucrt)
    -   `tidyverse` \[v.1.3.2\]
    -   `data.table` \[v.1.14.2\]
    -   `rmarkdown` \[v.2.16\]

### My computer:

``` r
sessionInfo()
```

    ## R version 4.2.0 (2022-04-22 ucrt)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19044)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United Kingdom.utf8 
    ## [2] LC_CTYPE=English_United Kingdom.utf8   
    ## [3] LC_MONETARY=English_United Kingdom.utf8
    ## [4] LC_NUMERIC=C                           
    ## [5] LC_TIME=English_United Kingdom.utf8    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] rmarkdown_2.16    data.table_1.14.2 forcats_0.5.2     stringr_1.4.1    
    ##  [5] dplyr_1.0.10      purrr_0.3.4       readr_2.1.2       tidyr_1.2.1      
    ##  [9] tibble_3.1.8      ggplot2_3.3.6     tidyverse_1.3.2  
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_1.1.2    xfun_0.33           haven_2.5.1        
    ##  [4] gargle_1.2.1        colorspace_2.0-3    vctrs_0.4.1        
    ##  [7] generics_0.1.3      htmltools_0.5.3     yaml_2.3.5         
    ## [10] utf8_1.2.2          rlang_1.0.6         pillar_1.8.1       
    ## [13] withr_2.5.0         glue_1.6.2          DBI_1.1.3          
    ## [16] dbplyr_2.2.1        modelr_0.1.9        readxl_1.4.1       
    ## [19] lifecycle_1.0.2     munsell_0.5.0       gtable_0.3.1       
    ## [22] cellranger_1.1.0    rvest_1.0.3         evaluate_0.16      
    ## [25] knitr_1.40          tzdb_0.3.0          fastmap_1.1.0      
    ## [28] fansi_1.0.3         broom_1.0.1         scales_1.2.1       
    ## [31] backports_1.4.1     googlesheets4_1.0.1 jsonlite_1.8.0     
    ## [34] fs_1.5.2            hms_1.1.2           digest_0.6.29      
    ## [37] stringi_1.7.8       grid_4.2.0          cli_3.4.1          
    ## [40] tools_4.2.0         magrittr_2.0.3      crayon_1.5.1       
    ## [43] pkgconfig_2.0.3     ellipsis_0.3.2      xml2_1.3.3         
    ## [46] reprex_2.0.2        googledrive_2.0.0   lubridate_1.8.0    
    ## [49] assertthat_0.2.1    httr_1.4.4          rstudioapi_0.14    
    ## [52] R6_2.5.1            compiler_4.2.0
