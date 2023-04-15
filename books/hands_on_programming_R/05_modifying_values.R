#### Hands-On Programming with R by Garrett Grolemund - Script
# 7 Modifying Values
# https://rstudio-education.github.io/hopr/modify.html#modify
# 2023_04_15
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Modifying Values ----

# Working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

# Data used (as "deck")
deck <- read.csv("datasets/cards.csv")
head(deck)

#### 7 Modifying Values ----

# In this task, you will change the point system of your deck three times to 
# match three different games: war, hearts, and blackjack.

# Start by making a copy of deck that you can manipulate. This will ensure that
# you always have a pristine copy of deck to fall back on (should things go awry):
deck2 <- deck

#### 7.0.1 Changing Values in Place ----
# First, describe the value (or values) you wish to modify. Then use the 
# assignment operator <- to overwrite those values. R will update the selected 
# values in the original object. Let’s put this into action with a real example:
vec <- c(0, 0, 0, 0, 0, 0)
vec
##  0 0 0 0 0 0

# Here’s how you can select the first value of vec:
vec[1]
##  0

# And here is how you can modify it:
vec[1] <- 1000
vec
## 1000    0    0    0    0    0

# You can replace multiple values at once as long as the number of new values 
# equals the number of selected values:
vec[c(1, 3, 5)] <- c(1, 1, 1)
vec
##  1 0 1 0 1 0

vec[4:6] <- vec[4:6] + 1
vec
## 1 0 1 1 2 1

# You can also create values that do not yet exist in your object. 
# R will expand the object to accommodate the new values:
vec[7] <- 0
vec
## 1 0 1 1 2 1 0

# This provides a great way to add new variables to your data set:
deck2$new <- 1:52

head(deck2)
##   face   suit value new
##   king spades    13   1
##  queen spades    12   2
##   jack spades    11   3
##    ten spades    10   4
##   nine spades     9   5
##  eight spades     8   6

# You can also remove columns from a data frame (and elements from a list) by 
# assigning them the symbol NULL:
deck2$new <- NULL

head(deck2)
##   face   suit value
##   king spades    13
##  queen spades    12
##   jack spades    11
##    ten spades    10
##   nine spades     9
##  eight spades     8

#### The Game of War (aces = 14) ----
# In the game of war, aces are king (figuratively speaking). They receive the 
# highest value of all the cards, which would be something like 14. Every other 
# card gets the value that it already has in deck. To play war, you just need to 
# change the values of your aces from 1 to 14.

# As long as you haven’t shuffled your deck, you know just where the aces are. 
# They appear every 13 cards. Hence, you can describe them with R’s notation system:
deck2[c(13, 26, 39, 52), ]
##  face     suit value
##   ace   spades     1
##   ace    clubs     1
##   ace diamonds     1
##   ace   hearts     1

# You can single out just the values of the aces by subsetting the columns 
# dimension of deck2. Or, even better, you can subset the column vector deck2$value:
  
deck2[c(13, 26, 39, 52), 3]
## 1 1 1 1

deck2$value[c(13, 26, 39, 52)]
## 1 1 1 1

# assign a new set of values to these old values. save c(14, 14, 14, 14) into the 
# ace values, or you could just save 14 and rely on R’s recycling rules to 
# expand 14 to c(14, 14, 14, 14):
deck2$value[c(13, 26, 39, 52)] <- c(14, 14, 14, 14)

# or
deck2$value[c(13, 26, 39, 52)] <- 14

head(deck2, 13)

# shuffle things up
deck3 <- shuffle(deck)
# Where are the aces now?
head(deck3)
##  face     suit value
##   ... ... ...
##   ace   spades     1   # an ace

#### 7.0.2 Logical Subsetting ----

# Operator	Syntax	Tests

#  >	a > b	Is a greater than b?
#  >=	a >= b	Is a greater than or equal to b?
#  <	a < b	Is a less than b?
#  <=	a <= b	Is a less than or equal to b?
#  ==	a == b	Is a equal to b?
#  !=	a != b	Is a not equal to b?
#  %in%	a %in% c(a, b, c)	Is a in the group c(a, b, c)?

# Each operator returns a TRUE or a FALSE. If you use an operator to compare 
# vectors, R will do element-wise comparisons—just like it does with the 
# arithmetic operators:
  
1 > 2
## FALSE

1 > c(0, 1, 2)
## TRUE FALSE FALSE

c(1, 2, 3) == c(3, 2, 1)
## FALSE  TRUE FALSE

# %in% will independently test whether each value on the left is somewhere in 
# the vector on the right:

1 %in% c(3, 4, 5)
## FALSE

c(1, 2) %in% c(3, 4, 5)
## FALSE FALSE

c(1, 2, 3) %in% c(3, 4, 5)
## FALSE FALSE  TRUE

c(1, 2, 3, 4) %in% c(3, 4, 5)
## FALSE FALSE  TRUE  TRUE

#### Exercise 7.1 (How many Aces?) 
# Extract the face column of deck2 and test whether each value is equal to ace. 
# As a challenge, use R to quickly count how many cards are equal to ace.

#### Solution. You can extract the face column with R’s $ notation:
deck2$face
##  "king"  "queen" "jack"  "ten"   "nine" 
##  "eight" "seven" "six"   "five"  "four" 
##  "three" "two"   "ace"   "king"  "queen"
##  "jack"  "ten"   "nine"  "eight" "seven"
##  "six"   "five"  "four"  "three" "two"  
##  "ace"   "king"  "queen" "jack"  "ten"  
##  "nine"  "eight" "seven" "six"   "five" 
##  "four"  "three" "two"   "ace"   "king" 
##  "queen" "jack"  "ten"   "nine"  "eight"
##  "seven" "six"   "five"  "four"  "three"
##  "two"   "ace"

# Next, you can use the == operator to test whether each value is equal to ace. 
# In the following code, R will use its recycling rules to indivuidually compare 
# every value of deck2$face to "ace". Notice that the quotation marks are 
# important. If you leave them out, R will try to find an object named ace to 
# compare against deck2$face:
  
deck2$face == "ace"
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE  TRUE

# use sum to quickly count the number of TRUE
sum(deck2$face == "ace")
## 4

# You can use this method to spot and then change the aces in your deck—even if 
# you’ve shuffled your cards. 
deck3$face == "ace"

# Then use the test to single out the ace point values. Since the test returns 
# a logical vector, you can use it as an index:
deck3$value[deck3$face == "ace"]
##  1 1 1 1

# Finally, use assignment to change the ace values in deck3:
deck3$value[deck3$face == "ace"] <- 14

head(deck3)
## 23 four    clubs     4
## 29 jack diamonds    11
## 35 five diamonds     5
## 42 jack   hearts    11
## 44 nine   hearts     9
## 13  ace   spades    14  # an ace

#### The Game of Hearts (hearts valued, other cards value = 0) ----
# In hearts, every card has a value of zero, except cards in the suit of hearts 
# and the queen of spades. Each card in the suit of hearts has a value of 1:



#### 7.0.1 Changing Values in Place ----



#### 7.0.1 Changing Values in Place ----
