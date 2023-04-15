#### Hands-On Programming with R by Garrett Grolemund - Script
# 6. R Notation
# https://rstudio-education.github.io/hopr/r-notation.html
# 2023_04_13
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### R Notation ----

# Working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

# Data used (as "deck")
deck <- read.csv("datasets/cards.csv")
head(deck)

# Task set for this chapter:
# - shuffle cards in a deck from time to time
# - deal cards from the deck (one card at a time, whenever card is on top)

#### 6.1 Selecting Values ----
# To extract a value or set of values from a data frame, write the data frame’s 
# name followed by a pair of hard brackets:
deck[ , ]
# Between the brackets will go two indexes separated by a comma^
# - the first index to subset the rows of the data frame and 
# - the second index to subset the columns.

# There are six different ways to write an index for R, create indexes with:
# -- Positive integers
# -- Negative integers
# -- Zero
# -- Blank spaces
# -- Logical values
# -- Names

#### 6.1.1 Positive Integers ----

#### ----

#### ----

#### ----

#### ----

#### ----

#### ----











