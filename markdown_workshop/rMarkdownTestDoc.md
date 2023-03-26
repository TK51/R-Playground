RMarkdown Test Document
================
TK51
2023-03-26

``` r
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
getwd()
```

    ## [1] "/home/t51/DataAnalytics/R-Playground/markdown_workshop"

``` r
edidiv <- read.csv("/home/t51/DataAnalytics/R-Playground/coding_club/datasets/edidiv.csv")

# check that the data was imported without any mistakes
head(edidiv) # displays the first few rows
```

    ##                      organisationName gridReference year         taxonName
    ## 1 Joint Nature Conservation Committee      NT265775 2000    Sterna hirundo
    ## 2 Joint Nature Conservation Committee      NT235775 2000    Sterna hirundo
    ## 3 Joint Nature Conservation Committee      NT235775 2000 Sterna paradisaea
    ## 4       British Trust for Ornithology          NT27 2000 Branta canadensis
    ## 5       British Trust for Ornithology          NT27 2000  Branta leucopsis
    ## 6     The Wildlife Information Centre         NT27S 2001     Turdus merula
    ##   taxonGroup
    ## 1       Bird
    ## 2       Bird
    ## 3       Bird
    ## 4       Bird
    ## 5       Bird
    ## 6       Bird

``` r
tail(edidiv) # displays the last few rows
```

    ##                            organisationName gridReference year
    ## 25679                    The Mammal Society      NT278745 2016
    ## 25680                    The Mammal Society      NT277724 2016
    ## 25681                    The Mammal Society      NT266728 2016
    ## 25682                    The Mammal Society      NT270728 2016
    ## 25683                    The Mammal Society      NT257762 2016
    ## 25684 People's Trust for Endangered Species        NT2372 2016
    ##                   taxonName taxonGroup
    ## 25679  Sciurus carolinensis     Mammal
    ## 25680   Capreolus capreolus     Mammal
    ## 25681  Sciurus carolinensis     Mammal
    ## 25682 Oryctolagus cuniculus     Mammal
    ## 25683         Vulpes vulpes     Mammal
    ## 25684   Erinaceus europaeus     Mammal

``` r
str(edidiv) # see the variables types: continuous, integers, categorical, chars
```

    ## 'data.frame':    25684 obs. of  5 variables:
    ##  $ organisationName: chr  "Joint Nature Conservation Committee" "Joint Nature Conservation Committee" "Joint Nature Conservation Committee" "British Trust for Ornithology" ...
    ##  $ gridReference   : chr  "NT265775" "NT235775" "NT235775" "NT27" ...
    ##  $ year            : int  2000 2000 2000 2000 2000 2001 2001 2001 2001 2001 ...
    ##  $ taxonName       : chr  "Sterna hirundo" "Sterna hirundo" "Sterna paradisaea" "Branta canadensis" ...
    ##  $ taxonGroup      : chr  "Bird" "Bird" "Bird" "Bird" ...
