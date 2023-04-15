#### Hands-On Programming with R by Garrett Grolemund - Script
# 8 Environments
# https://rstudio-education.github.io/hopr/environments.html
# 2023_04_15
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Environments ----

# Working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

# Data used (as "deck")
deck <- read.csv("datasets/cards.csv")
head(deck)