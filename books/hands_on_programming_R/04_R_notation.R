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
# just like ij notation in linear algebra: 
# deck[i,j] will return the value of deck that is in the ith row and the jth column
head(deck, 3)
##  face   suit value
##  king spades    13
## queen spades    12
##  jack spades    11

deck[1, 1]
## "king"

# To extract more than one value, use a vector of positive integers. For example, 
# you can return the first row of deck with deck[1, c(1, 2, 3)] or deck[1, 1:3]:
deck[1, c(1, 2, 3)]
## face   suit value
## king spades    13

deck[7, c(1:3)]
## face   suit value
## seven spades   7

new <- deck[1, c(1, 2, 3)]
new
## face   suit value
## king spades    13

# If you repeat a number in your index, R will return the corresponding value(s) 
#more than once in your “subset.” This code will return the first row of 
# deck twice:
deck[c(1, 1), c(1, 2, 3)]
## face   suit value
## king spades    13
## king spades    13

deck[c(1, 3), c(1, 2, 3)]
## face   suit value
## king spades    13
## jack spades    11

deck[c(1:3), c(1, 2, 3)]
## face   suit value
## king spades    13
## queen spades   12
## jack spades    11

#### -- drop = FALSE --
# If you select two or more columns from a data frame, R will return a new data frame:
deck[1:2, 1:2]
##  face   suit
##  king spades
## queen spades

# However, if you select a single column, R will return a vector:
deck[1:2, 1]
##  "king"  "queen"

# If you would prefer a data frame instead, you can add the optional argument 
# drop = FALSE between the brackets:
  
deck[1:2, 1, drop = FALSE]
##  face
##  king
## queen

# This method also works for selecting a single column from a matrix or an array.

#### ----

#### ----

#### ----

#### ----

#### ----

#### ----











