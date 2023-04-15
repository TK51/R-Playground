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

#### 6.1.2 Negative Integers ----
# Negative integers do the exact opposite of positive integers when indexing. 
# R will return every element except the elements in a negative index. 
# deck[-1, 1:3] will return everything but the first row of deck
deck[-1, 1:3]
## get the 51-card deck

deck[-(2:52), 1:3]
## face   suit value
## king spades    13

# R will return an error if you try to pair a negative integer with a positive 
# integer in the same index:
deck[c(-1, 1), 1]
## Error in xj[i] : only 0's ...

# However, you can use both negative and positive integers to subset an object 
# if you use them in different indexes (e.g., if you use one in the rows index 
# and one in the columns index, like deck[-1, 1]).
deck[-1, 1]
## get the whole list of faces except the king

#### 6.1.3 Zero ----

# What would happen if you used zero as an index? Zero is neither a positive 
# integer nor a negative integer, but R will still use it to do a type of 
# subsetting. R will return nothing from a dimension when you use zero as an 
# index. 

# This creates an empty object:
deck[0, 0]
## data frame with 0 columns and 0 rows

#### 6.1.4 Blank Spaces ----
# You can use a blank space to tell R to extract every value in a dimension.
# This lets you subset an object on one dimension but not the others, which is 
# useful for extracting entire rows or columns from a data frame:
deck[1, ]
## face   suit value
## king spades    13

#### 6.1.5 Logical Values ----
# If you supply a vector of TRUEs and FALSEs as your index, R will match each 
# TRUE and FALSE to a row in your data frame (or a column depending on where you 
# place the index). R will then return each row that corresponds to a TRUE,
deck[1, c(TRUE, TRUE, FALSE)]
## face   suit 
## king spades

rows <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, 
          F, F, F, F, F, F, F, F, F, F, F, F, F, F, TRUE, F, F, F, F, F, F, F, 
          F, F, F, F, F, F, F, F, F, F, F, F, F, F)
deck[rows, ]
## face   suit value
## king spades    13
## nine diamonds   9

# You can use vectors of TRUEs and FALSEs to tell R exactly which values you 
# want to extract and which you do not like vec[c(F, T, F, T, F, T)]

#### 6.1.6 Names ----
# Finally, you can ask for the elements you want by name—if your object has names 
# (see Names). This is a common way to extract the columns of a data frame, since 
# columns almost always have names:
deck[1, c("face", "suit", "value")]
## face   suit value
## king spades    13

# the entire value column
deck[ , "value"]
##  13 12 11 10  9  8  7  6  5  4  3  2  1 13 12 11 10  9  8
##  7  6  5  4  3  2  1 13 12 11 10  9  8  7  6  5  4  3  2
##  1 13 12 11 10  9  8  7  6  5  4  3  2  1


#### 6.2 Deal a Card ----

# Exercise 6.1 (Deal a Card) 

# Complete the following code to make a function that returns the first row of a data frame:
deal <- function(cards) {
    # ?
  }
# Solution. 
# You can use any of the systems that return the first row of your data frame to 
# write a deal function. I’ll use positive integers and blanks because I think 
#they are easy to understand:
deal <- function(cards) {
    cards[1, ]
  }

deal(deck)
## face   suit value
## king spades    13

deal(deck)
## face   suit value
## king spades    13

#deal always returns the king of spades because deck doesn’t know that we’ve 
# dealt the card away.

#### 6.3 Shuffle the Deck ----
# When you shuffle a real deck of cards, you randomly rearrange the order of the 
# cards. In your virtual deck, each card is a row in a data frame. To shuffle the 
# deck, you need to randomly reorder the rows in the data frame. Can this be done? 
# You bet! And you already know everything you need to do it.

# his may sound silly, but start by extracting every row in your data frame:
  
deck2 <- deck[1:52, ]

head(deck2)
##   face   suit value
##   king spades    13
##  queen spades    12
##   jack spades    11
##    ten spades    10
##   nine spades     9
##  eight spades     8








