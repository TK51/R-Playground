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

#### Exercise 6.1 (Deal a Card) 

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

# What do you get? A new data frame whose order hasn’t changed at all. What if 
# you asked R to extract the rows in a different order? For example, you could 
# ask for row 2, then row 1, and then the rest of the cards:

deck3 <- deck[c(2, 1, 3:52), ]

head(deck3)
##   face   suit value
##  queen spades    12
##   king spades    13
##   jack spades    11
##    ten spades    10
##   nine spades     9
##  eight spades     8

# R complies. You’ll get all the rows back, and they’ll come in the order you 
# ask for them. If you want the rows to come in a random order, then you need to
# sort the integers from 1 to 52 into a random order and use the results as a 
# row index. How could you generate such a random collection of integers? With 
#our friendly neighborhood sample function:

random <- sample(1:52, size = 52)
random
##  35 28 39  9 18 29 26 45 47 48 23 22 21 16 32 38  1 15 20
##  11  2  4 14 49 34 25  8  6 10 41 46 17 33  5  7 44  3 27
##  50 12 51 40 52 24 19 13 42 37 43 36 31 30

deck4 <- deck[random, ]
head(deck4)
##   face     suit value
##   five diamonds     5
##  queen diamonds    12
##    ace diamonds     1
##   five   spades     5
##   nine    clubs     9
##   jack diamonds    11

# Now the new set is truly shuffled. You’ll be finished once you wrap these 
# steps into a function.

#### Exercise 6.2 (Shuffle a Deck) 
# Use the preceding ideas to write a shuffle function. shuffle should take a data frame and return a shuffled copy of the data frame.
# Solution. Your shuffle function will look like the one that follows:
shuffle <- function(cards) { 
    random <- sample(1:52, size = 52)
    cards[random, ]
  }
# Nice work! Now you can shuffle your cards between each deal:
  
deal(deck)
## face   suit value
## king spades    13

deck2 <- shuffle(deck) 

deal(deck2)
## face  suit value
## jack clubs    11

#### 6.4 Dollar Signs and Double Brackets ----
# Two types of object in R obey an optional second system of notation. 
# You can extract values from data frames and lists with the $ syntax
deck$value
## 13 12 11 10  9  8  7  6  5  4  3  2  1 13 12 11 10  9  8  7
##  6  5  4  3  2  1 13 12 11 10  9  8  7  6  5  4  3  2  1 13
## 12 11 10  9  8  7  6  5  4  3  2  1

# un a function like mean or median on the values in a variable
mean(deck$value)
## 7

median(deck$value)
## 7

# You can use the same $ notation with the elements of a list, if they have names
lst <- list(numbers = c(1, 2), logical = TRUE, strings = c("a", "b", "c"))
lst
## $numbers
## [1] 1 2

## $logical
## [1] TRUE

## $strings
## [1] "a" "b" "c"

# And then subset it:
lst[1]
## $numbers
## [1] 1 2

# When you use the $ notation, R will return the selected values as they are, 
# with no list structure around them:
lst$numbers
## 1 2

# You can then immediately feed the results to a function:
sum(lst$numbers)
## 3

# If the elements in your list do not have names (or you do not wish to use the 
# names), you can use two brackets, instead of one, to subset the list. This 
# notation will do the same thing as the $ notation:
lst[[1]]
## 1 2

# In other words, if you subset a list with single-bracket notation, R will 
# return a smaller list. If you subset a list with double-bracket notation, R 
# will return just the values that were inside an element of the list. You can 
# combine this feature with any of R’s indexing methods:  
lst["numbers"]
## $numbers
## [1] 1 2

lst[["numbers"]]
## 1 2

#### 6.5 Summary ----
# You have learned how to access values that have been stored in R. You can 
# retrieve a copy of values that live inside a data frame and use the copies for
# new computations.

# In fact, you can use R’s notation system to access values in any R object. 
# To use it, write the name of an object followed by brackets and indexes. 
# If your object is one-dimensional, like a vector, you only need to supply one 
# index. If it is two-dimensional, like a data frame, you need to supply two 
# indexes separated by a comma. And, if it is n-dimensional, you need to 
# supply n indexes, each separated by a comma.










