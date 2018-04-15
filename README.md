
<!-- README.md is generated from README.Rmd. Please edit that file -->

# select4lists

Dplyr’s `select()` for named lists.

## Installation

You can install select4lists from github with:

``` r
# install.packages("devtools")
devtools::install_github("Athospd/select4lists")
```

## Dplyr functions implemented

  - select()
  - rename()

## Example

``` r
library(dplyr)
library(select4lists)
iris_as_list <- as.list(iris %>% head)

iris_as_list %>% select(Species)
#> $Species
#> [1] setosa setosa setosa setosa setosa setosa
#> Levels: setosa versicolor virginica
iris_as_list %>% select(starts_with("Sepal"))
#> $Sepal.Length
#> [1] 5.1 4.9 4.7 4.6 5.0 5.4
#> 
#> $Sepal.Width
#> [1] 3.5 3.0 3.2 3.1 3.6 3.9
iris_as_list %>% select(2:3)
#> $Sepal.Width
#> [1] 3.5 3.0 3.2 3.1 3.6 3.9
#> 
#> $Petal.Length
#> [1] 1.4 1.4 1.3 1.5 1.4 1.7
iris_as_list %>% select(-contains("."))
#> $Species
#> [1] setosa setosa setosa setosa setosa setosa
#> Levels: setosa versicolor virginica
```
