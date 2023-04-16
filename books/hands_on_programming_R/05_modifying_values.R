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

deck4 <- deck
deck4$value <- 0

head(deck4, 13)
##   face   suit value
##   king spades     0
##  queen spades     0
##   jack spades     0
##    ten spades     0
##   nine spades     0
##  eight spades     0
##  seven spades     0
##    six spades     0
##   five spades     0
##   four spades     0
##  three spades     0
##    two spades     0
##    ace spades     0

#### Exercise 7.2 (Score the Deck for Hearts) 
# Assign a value of 1 to every card in deck4 that has a suit of hearts.
#### Solution.
# To do this, first write a test that identifies cards in the hearts suit:

deck4$suit == "hearts"
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE
##   TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
##   TRUE  TRUE  TRUE

# Then use your test to select the values of these cards:
deck4$value[deck4$suit == "hearts"]
## 0 0 0 0 0 0 0 0 0 0 0 0 0

# Finally, assign a new number to these values:
deck4$value[deck4$suit == "hearts"] <- 1

# Now all of your hearts cards have been updated:
deck4$value[deck4$suit == "hearts"]
## 1 1 1 1 1 1 1 1 1 1 1 1 1

# In hearts, the queen of spades has the most unusual value of all: she’s worth 
# 13 points. It should be simple to change her value, but she’s surprisingly
# hard to find. You could find all of the queens:

deck4[deck4$face == "queen", ]
##   face     suit value
##  queen   spades     0
##  queen    clubs     0
##  queen diamonds     0
##  queen   hearts     1

# But that’s three cards too many. On the other hand, you could find all of 
# the cards in spades:
deck4[deck4$suit == "spades", ]

# use a Boolean operator to locate the queen of spades in your deck:
deck4$face == "queen" & deck4$suit == "spades"
##  FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  FALSE FALSE FALSE

# save the results of this test to its own object
queenOfSpades <- deck4$face == "queen" & deck4$suit == "spades"

# use the test as an index to select the value of the queen of spades. 
# Make sure the test actually selects the correct value:
deck4[queenOfSpades, ]
##  face   suit value
## queen spades     0

deck4$value[queenOfSpades]
## 0

# Now that you’ve found the queen of spades, you can update her value:
deck4$value[queenOfSpades] <- 13

deck4[queenOfSpades, ]
##  face   suit value
## queen spades     13

#### Logical games ----
#### Exercise 7.3 (Practice with Tests) 
# If you think you have the hang of logical tests, try converting these sentences 
# into tests written with R code. To help you out, I’ve defined some R objects 
# after the sentences that you can use to test your answers:

# - Is w positive?
# - Is x greater than 10 and less than 20?
# - Is object y the word February?
# - Is every value in z a day of the week?
w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")
#### Solution. 
# Here are some model answers. If you got stuck, be sure to re-read how R 
# evaluates logical tests that use Boolean values:
w > 0
10 < x & x < 20
y == "February"
all(z %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", 
             "Saturday", "Sunday"))

#### The Game of BlackJack ----
# In blackjack, each number card has a value equal to its face value. Each face 
# card (king, queen, or jack) has a value of 10. Finally, each ace has a value 
# of 11 or 1, depending on the final results of the game.

# begin with the new deck
deck5 <- deck

head(deck5, 13)
##   king spades    13
##  queen spades    12
##   jack spades    11
##    ten spades    10
##   nine spades     9
##  eight spades     8
##  seven spades     7
##    six spades     6
##   five spades     5
##   four spades     4
##  three spades     3
##    two spades     2
##    ace spades     1

# change the value of the face cards in one fell swoop with %in%:
facecard <- deck5$face %in% c("king", "queen", "jack")

deck5[facecard, ]
##   face     suit value
##   king   spades    13
##  queen   spades    12
##   jack   spades    11
##   king    clubs    13
##  queen    clubs    12
##   jack    clubs    11
##   king diamonds    13
##  queen diamonds    12
##   jack diamonds    11
##   king   hearts    13
##  queen   hearts    12
##   jack   hearts    11

deck5$value[facecard] <- 10

head(deck5, 13)
##   face   suit value
##   king spades    10
##  queen spades    10
##   jack spades    10
##    ten spades    10
##   nine spades     9
##  eight spades     8
##  seven spades     7
##    six spades     6
##   five spades     5
##   four spades     4
##  three spades     3
##    two spades     2
##    ace spades     1

# there's no info at the moment to assign for aces - 1 or 11...

#### 7.0.3 Missing Information ----

# NA character is a special symbol in R. It stands for “not available” and can 
# be used as a placeholder for missing information
1 + NA
## NA

NA == 1
## NA

# Generally, NAs will propagate whenever you use them in an R operation or 
# function. This can save you from making errors based on missing data.

#### 7.0.3.1 na.rm ----

# if even one of the values is NA, your result will be NA:
c(NA, 1:50)
## NA  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
## 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
## 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50

mean(c(NA, 1:50))
## NA

# Most R functions come with the optional argument, na.rm, which stands for NA 
# remove. R will ignore NAs when it evaluates a function if you add the 
# argument na.rm = TRUE:

mean(c(NA, 1:50), na.rm = TRUE)
## 25.5

#### 7.0.3.2 is.na ----
# R supplies a special function that can test whether a value is an NA. The 
# function is sensibly named is.na:

is.na(NA)
## TRUE

vec <- c(1, 2, 3, NA)
is.na(vec)
## FALSE FALSE FALSE  TRUE

# Let’s set all of your ace values to NA
# You can set your ace values to NA in the same way that you would set them to a number:

deck5$value[deck5$face == "ace"] <- NA

head(deck5, 13)
##   face   suit value
##   king spades    10
##  queen spades    10
##   jack spades    10
##    ten spades    10
##   nine spades     9
##  eight spades     8
##  seven spades     7
##    six spades     6
##   five spades     5
##   four spades     4
##  three spades     3
##    two spades     2
##    ace spades    NA

# Congratulations. Your deck is now ready for a game of blackjack.

#### 7.0.4 Summary ----
# You can modify values in place inside an R object when you combine R’s notation 
# syntax with the assignment operator, <-. This lets you update your data and 
# clean your data sets














