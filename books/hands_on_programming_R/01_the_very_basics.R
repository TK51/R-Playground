#### Hands-On Programming with R by Garrett Grolemund - Script
# 2. The Very Basics
# https://rstudio-education.github.io/hopr/basics.html
# 2023_04_11
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### The Very Basics ----

# clean the slate and start from the clear page
rm(list = ls())

# Working directory 
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

# having an interval
10:31

name <- "a"
name

## Making a die (dies)
# make a vector, a one-dimensional set of numbers
1:6

# creating an object named "die"
die <- 1:6
die

# check all the created object names within the environment
ls()

# play with the die
die - 1
die / 2
die * die

1:2
die + 1:2

1:4
die + 1:4

# matrix inner multiplication (with %*%)
die %*% die

# matrix outer multiplication (with %o%)
die %o% die

# basic functins - round and factorial
round(3.1567)  # 3
factorial(3)   # 6

# function logic - from innermost to the outermost
mean(1:6)  # 3.5

mean(die)  # 3.5

round(mean(die))  # 4

# you can simulate a roll of the die with R’s sample function, takes 2 args -
# a vector named x and a number named size.
sample(x = 1:6, size = 2)  # 2 5 or 1 3 or 2 3

# roll a die by setting x = die and size = 1 (as one element to be rolled)
sample(x = die, size = 1) 

# re-shaped function with name 'die' used directly as x
sample(die, size = 1)

# re-shaped function with name 'die' used directly as x and '1' set as size
sample(die, 1)

#### Get the help on function ARGUMENTS by using 'args()' function
args(sample)
# function (x, size, replace = FALSE, prob = NULL) 
# NULL

args(round)  
# function (x, digits = 0) #
# NULL

# use functions optional arguments overriding the default ones
round(3.1415)  # 3

round(3.1415, digits = 2)  # 3.14

# using arguments names prevents from mistakes in arguments selection
# As a result, values may get passed to the wrong argument. Argument names 
# prevent this. R will always match a value to its argument name, no matter 
# where it appears in the order of arguments:
sample(size = 1, x = die)  # 2

# simulate a pair of dies, but by default, sample builds a sample without replacement
sample(x = die, size = 2)  # 2 6

# You can recreate this behavior in sample by adding the argument replace = TRUE
sample(die, size = 2, replace = TRUE)  # 2 2

# This is the correct way to simulate a pair of dice:
sample(die, size = 2, replace = TRUE)  # 2 4

# making two dice
dice <- sample(die, size = 2, replace = TRUE)
dice  # 2 4 Once you save a set of results to an R object, those results do not change

# To recap, you already have working R code that simulates rolling a pair of dice:
die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
dice
sum(dice)

# We’re going to write a function named roll()  to roll your virtual dice
# the function will work like this: each time you call roll(), 
# R will return the sum of rolling two dice

# Every function in R has three basic parts: 
# a name, a body of code, and a set of arguments
my_function <- function() {}

roll <- function() {                             # function name
  die <- 1:6                                     # body
  dice <- sample(die, size = 2, replace = TRUE)  # body
  sum(dice)                                      # output
}

roll()  # 7

# If you type in a function’s name without the parentheses, R will show you the 
# code that is stored inside the function. If you type in the name with the
# parentheses, R will run that code:

roll
## function() {
##   die <- 1:6
##   dice <- sample(die, size = 2, replace = TRUE)
##   sum(dice)
## }
roll()
## 8

roll2 <- function(die = 1:6) {                   # function name with default args
  dice <- sample(die, size = 2, replace = TRUE) # body
  #sum(dice)                                    # output
  dice                                          # output
}
roll2()

# a function with changed defaults
roll(die = 5:9)

roll <- function(die = 1:6) {                   # function name with default args
  dice <- sample(die, size = 2, replace = TRUE)  # body
  sum(dice)                                      # output
  # dice                                         # output
}
roll()









