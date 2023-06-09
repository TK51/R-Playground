#### Hands-On Programming with R by Garrett Grolemund - Script
# 5. R Objects
# https://rstudio-education.github.io/hopr/r-objects.html
# 2023_04_12
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### R Objects ----
#### 5.1 Atomic Vectors ----

# You can make an atomic vector by grouping some values of data together with c:
die <- c(1, 2, 3, 4, 5, 6)
die  # 1 2 3 4 5 6

is.vector(die)  
## TRUE

# vector can include a single value
five <- 5
five  
## 5

is.vector(five)  ##  TRUE

length(five)  
## 1
length(die)  
## 6

#### 5.1.1 Doubles ----
die <- c(1, 2, 3, 4, 5, 6)
die  
## 1 2 3 4 5 6

typeof(die)  
## "double" or numerics

# 5.1.2 Integers ----
int <- c(-1L, 2L, 4L)
int
## -1  2  4

typeof(int)
## "integer"

#### 5.1.3 Characters ----
text <- c("Hello",  "World")
text
##  "Hello"  "World"

typeof(text)
## "character"

typeof("Hello")
## "character"

#### 5.1.4 Logicals ----
3 > 4
## FALSE

logic <- c(TRUE, FALSE, TRUE)
logic
##   TRUE FALSE  TRUE

typeof(logic)
## "logical"

typeof(F)
## "logical"

#### 5.1.5 Complex and Raw ----
# Complex vectors store complex numbers. To create a complex vector, 
# add an imaginary term to a number with i:

comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp
## 1+1i 1+2i 1+3i

typeof(comp)
## "complex"

# you can make an empty raw vector of length n with raw(n)
raw(3)
## 00 00 00

typeof(raw(3))
## "raw"

#### Exercise 5.2 (Vector of Cards) - Create an atomic vector that stores just 
# the face names of the cards in a royal flush
hand <- c("ace", "king", "queen", "jack", "ten")
hand
## "ace"   "king"  "queen" "jack"  "ten"  - a one-dimensional group of card names

typeof(hand)
## "character"

#### 5.2 Attributes ----
# You can see which attributes an object has with attributes. attributes will 
# return NULL if an object has no attributes. An atomic vector, like die,
# won’t have any attributes unless you give it some:
attributes(die)
## NULL

#### 5.2.1 Names ----
# The most common attributes to give an atomic vector are names, 
# dimensions (dim), and classes

names(die)
## NULL - means that die does not have a names attribute. 

#You can give one to die by assigning a character vector to the output of names. 
# The vector should include one name for each element in die:
  
names(die) <- c("one", "two", "three", "four", "five", "six")

# Now die has a names attribute:
names(die)
## "one"   "two"   "three" "four"  "five"  "six" 

attributes(die)
## $names
## [1] "one"   "two"   "three" "four"  "five"  "six"

# R will display the names above the elements of die whenever you look at the vector:
die
##  one   two three  four  five   six 
##    1     2     3     4     5     6 

die + 1  # names won't change, just the values
##  one   two three  four  five   six 
##    2     3     4     5     6     7

# To change the names, assign a new set of labels to names:
names(die) <- c("uno", "dos", "tres", "quatro", "cinco", "seis")
die
##   uno    dos   tres quatro  cinco   seis 
##     1      2      3      4      5      6 

# To remove the names attribute, set it to NULL:
names(die) <- NULL
die
##  1 2 3 4 5 6

#### 5.2.2 Dim ----
# set the dim attribute to a numeric vector of length n
# reorganize die into a 2 × 3 matrix (which has 2 rows and 3 columns):
dim(die) <- c(2, 3)
die
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6

# or a 3 × 2 matrix (which has 3 rows and 2 columns):
dim(die) <- c(3, 2)
die
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6

# or a 1 × 2 × 3 hypercube (which has 1 row, 2 columns, and 3 “slices”)
dim(die) <- c(1, 2, 3)
die
## , , 1
## 
##      [,1] [,2]
## [1,]    1    2
## 
## , , 2
## 
##      [,1] [,2]
## [1,]    3    4
## 
## , , 3
## 
##      [,1] [,2]
## [1,]    5    6

#### 5.3 Matrices ----

# a matrix made by column
m <- matrix(die, nrow = 2)
m
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6

# a matrix made by row
m <- matrix(die, nrow = 2, byrow = TRUE)
m
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6

#### 5.4 Arrays ----

# create an array
ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))
ar
## , , 1
## 
##      [,1] [,2]
## [1,]   11   13
## [2,]   12   14
## 
## , , 2
## 
##      [,1] [,2]
## [1,]   21   23
## [2,]   22   24
## 
## , , 3
## 
##      [,1] [,2]
## [1,]   31   33
## [2,]   32   34

# Exercise 5.3 (Make a Matrix) Create the following matrix, which stores the
# name and suit of every card in a royal flush.
##      [,1]    [,2]    
## [1,] "ace"   "spades"
## [2,] "king"  "spades"
## [3,] "queen" "spades"
## [4,] "jack"  "spades"
## [5,] "ten"   "spades"
# Solution. 
# There is more than one way to build this matrix, but in every case, you 
# will need to start by making a character vector with 10 values. 
# If you start with the following character vector, you can turn it into a 
# matrix with any of the following three commands:
hand1 <- c("ace", "king", "queen", "jack", "ten", "spades", "spades", 
           "spades", "spades", "spades")

matrix(hand1, nrow = 5)
matrix(hand1, ncol = 2)
dim(hand1) <- c(5, 2)
dim(hand1)

# You can also start with a character vector that lists the cards in a 
# slightly different order. In this case, you will need to ask R to fill 
# the matrix row by row instead of column by column:

hand2 <- c("ace", "spades", "king", "spades", "queen", "spades", "jack", 
           "spades", "ten", "spades")

matrix(hand2, nrow = 5, byrow = TRUE)
matrix(hand2, ncol = 2, byrow = TRUE)
dim(hand2)

#### 5.5 Class ----
dim(die) <- c(2, 3)
typeof(die)
##  "double"

class(die)
##  "array"

attributes(die)
## $dim
## [1] 2 3

class("Hello")
##  "character"

class(5)
##  "numeric"

class(hand1)
## "matrix" "array" 

#### 5.5.1 Dates and Times ----
now <- Sys.time()
now
## "2023-04-13 06:19:26 CEST"

typeof(now)
##  "double"

class(now)
## "POSIXct" "POSIXt"

unclass(now)
## 1681359567

# what day it was a million seconds after 12:00 a.m. Jan. 1, 1970?
mil <- 1000000
mil
## 1e+06

class(mil) <- c("POSIXct", "POSIXt")
mil
## "1970-01-12 14:46:40 CET"

#### 5.5.2 Factors ----
# Factors make it easy to put categorical variables into a statistical model 
# because the variables are already coded as numbers.

# To make a factor, pass an atomic vector into the factor function
gender <- factor(c("male", "female", "female", "male"))

typeof(gender)
## "integer"

attributes(gender)
## $levels
## [1] "female" "male"  
## 
## $class
## [1] "factor"

# see exactly how R is storing your factor with unclass:
unclass(gender)
## [1] 2 1 1 2
## attr(,"levels")
## [1] "female" "male" 

gender
## male   female female male  
## Levels: female male

# convert a factor to a character string with the as.character function
as.character(gender)
## "male"   "female" "female" "male"

#### Exercise 5.4 (Write a Card) 
# Make a virtual playing card by combining “ace,” “heart,” and 1 into a vector. 
# What type of atomic vector will result? Check if you are right.

# Solution. 
# You may have guessed that this exercise would not go well. Each atomic vector 
# can only store one type of data. As a result, R coerces all of your values to 
# character strings:
card <- c("ace", "hearts", 1)
card
## "ace"    "hearts" "1" 
typeof(card)
## "character"

#### 5.6 Coercion ----
# R always follows the same rules when it coerces data types
# So how does R coerce data types?
# If a character string is present in an atomic vector, R will convert everything
# else in the vector to character strings. If a vector only contains logicals 
# and numbers, R will convert the logicals to numbers; every TRUE becomes a 1, 
#and every FALSE

# R uses the same coercion rules when you try to do math with logical values. 
# So the following code:

sum(c(TRUE, TRUE, FALSE, FALSE))
# will become:
  
sum(c(1, 1, 0, 0))
## 2

mean(c(TRUE, TRUE, FALSE, FALSE))
## 0.5 - given the above it calculates the average of 1, 1, 0, 0

# You can explicitly ask R to convert data from one type to another with the as 
# functions. R will convert the data whenever there is a sensible way to do so:
as.character(1)
## "1"

as.logical(1)
## TRUE

as.numeric(FALSE)
## 0

#### 5.7 Lists ----
# Lists are like atomic vectors because they group data into a one-dimensional set.
# list creates a list the same way c creates a vector. Separate each element 
# in the list with a comma:
list1 <- list(10:30, "R", list(TRUE, FALSE))
list1
## [[1]]
## [1] 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
## [18] 27 28 29 30
## 
## [[2]]
## [1] "R"
##
## [[3]]
## [[3]][[1]]
## [1] TRUE
##
## [[3]][[2]]
## [1] FALSE

#### Exercise 5.5 (Use a List to Make a Card) 
# Use a list to store a single playing card, like the ace of hearts, which has 
# a point value of one. The list should save the face of the card, the suit, 
# and the point value in separate elements.
# Solution. You can create your card like this. In the following example, the 
# first element of the list is a character vector (of length 1). The second 
#element is also a character vector, and the third element is a numeric vector:
card <- list("ace", "hearts", 1)
card
## [[1]]
## [1] "ace"
##
## [[2]]
## [1] "hearts"
##
## [[3]]
## [1] 1

#### 5.8 Data Frames ----
# Data frames are the two-dimensional version of a list. think of a data frame 
# as R’s equivalent to the Excel spreadsheet because it stores data in 
# a similar format

# Create a data frame with the data.frame function, Give data.frame any number 
# of vectors, each separated with a comma. Each vector should be set equal to 
#a name that describes the vector
df <- data.frame(face = c("ace", "two", "six"),  
                 suit = c("clubs", "clubs", "clubs"), 
                 value = c(1, 2, 3))
df
## face  suit value
##  ace clubs     1
##  two clubs     2
##  six clubs     3

typeof(df)
## "list"

class(df)
## "data.frame"

str(df)
## 'data.frame':    3 obs. of  3 variables:
##  $ face : Factor w/ 3 levels "ace","six","two": 1 3 2
##  $ suit : Factor w/ 1 level "clubs": 1 1 1
##  $ value: num  1 2 3

# create a data frame with family members
family <- data.frame(role = c("father", "mother", "son", "daughter"),
                     name = c("Taras", "Anna", "Oleksandr", "Taisiia"),
                     birth = c("1983", "1994", "2018", "2021"))
family
##     role      name birth
##   father     Taras  1983
##   mother      Anna  1994
##     son  Oleksandr  2018
## daughter   Taisiia  2021

family$role
## "father"   "mother"   "son"      "daughter"

typeof(family)  # "list"
class(family)   # "data.frame"
str(family)     # 'data.frame':	4 obs. of  3 variables

# make a data frame with factors by default
df <- data.frame(face = c("ace", "two", "six"),  
                 suit = c("clubs", "clubs", "clubs"), 
                 value = c(1, 2, 3),
                 stringsAsFactors = TRUE)
str(df)

# make a data frame with no factors by default
df <- data.frame(face = c("ace", "two", "six"),  
                 suit = c("clubs", "clubs", "clubs"), 
                 value = c(1, 2, 3),
                 stringsAsFactors = FALSE)
str(df)

# create a deck of 52 cards
# create this data frame with data.frame, but look at the typing involved! 
# You need to write three vectors, each with 52 elements:

deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", "ten", 
           "nine", "eight", "seven", "six", "five", "four", "three", "two", "ace", 
           "king", "queen", "jack", "ten", "nine", "eight", "seven", "six", "five", 
           "four", "three", "two", "ace", "king", "queen", "jack", "ten", "nine", 
           "eight", "seven", "six", "five", "four", "three", "two", "ace"),  
  suit = c("spades", "spades", "spades", "spades", "spades", "spades", 
           "spades", "spades", "spades", "spades", "spades", "spades", "spades", 
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", 
           "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds", 
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", 
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "hearts", 
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", 
           "hearts", "hearts", "hearts", "hearts", "hearts"), 
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 
            7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)

deck
##     face     suit value
## 1   king   spades    13
## 2  queen   spades    12
## 3   jack   spades    11
## 4    ten   spades    10
## ...
## 51   two   hearts     2
## 52   ace   hearts     1

head(deck)

# save a copy of deck as a new .csv file
write.csv(deck, 
          file = "books/hands_on_programming_R/datasets/cards.csv", 
          row.names = FALSE)

# row.names - excludes row numbers from the file





















