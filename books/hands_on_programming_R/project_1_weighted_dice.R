#### Hands-On Programming with R by Garrett Grolemund - Project 1
# Project 1: Weighted Dice
# 2023_04_12
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

# initiate package
library(ggplot2)

# function roll() with sum
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}
roll()

# function roll() with sum and higher chances for 6 to be rolled
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE, 
                 prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}
roll()