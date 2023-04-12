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









