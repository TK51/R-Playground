#### Hands-On Programming with R by Garrett Grolemund - Script
# 8 Environments
# https://rstudio-education.github.io/hopr/environments.html
# 2023_04_16
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Environments ----

# Working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

# Data used (as "deck")
deck <- read.csv("datasets/cards.csv")
head(deck)

# Your deck is now ready for a game of blackjack (or hearts or war), but are your 
# shuffle and deal functions up to snuff? Definitely not. For example, deal deals 
# the same card over and over again

# And the shuffle function doesn’t actually shuffle deck (it returns a copy of deck
# that has been shuffled). In short, both of these functions use deck, but neither 
# manipulates deck—and we would like them to.

# To fix these functions, you will need to learn how R stores, looks up, and 
# manipulates objects like deck. R does all of these things with the help of an 
# environment system.

#### 8.1 Environments ----
# You can see R’s environment system with the parenvs function in the pryr package
# (note parenvs came in the pryr package when this book was first published). 
# parenvs(all = TRUE) will return a list of the environments that your R session 
# is using. The actual output will vary from session to session depending on 
# which packages you have loaded. Here’s the output from my current session:

install.packages("pryr")
library(pryr)
parenvs(all = TRUE)
##    label                            name   
## 1  <environment: R_GlobalEnv>      1  ""       
## 2  <environment: package:pryr>     2  "package:pryr"  
## ... ... ...

























