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

#### 8.2 Working with Environments ----
# refer to any of the environments in your tree with as.environment. 
# as.environment takes an environment name (as a character string) 
# and returns the corresponding environment:

as.environment("package:stats")
## <environment: package:stats>
## attr(,"name")
## [1] "package:stats"
## attr(,"path")
## [1] "/usr/lib/R/library/stats"

# Three environments in your tree also come with their own accessor functions.
# These are the global environment (R_GlobalEnv), the base environment (base), 
# and the empty environment (R_EmptyEnv). You can refer to them with:
globalenv()
## <environment: R_GlobalEnv>

baseenv()
## <environment: base>

emptyenv()
##<environment: R_EmptyEnv>

# Next, you can look up an environment’s parent with parent.env:
parent.env(globalenv())
## <environment: package:pryr>
## attr(,"name")
## [1] "package:pryr"
## attr(,"path")
## [1] "/home/t51/R/x86_64-pc-linux-gnu-library/4.2/pryr"

# Notice that the empty environment is the only R environment without a parent:
parent.env(emptyenv())
## Error in parent.env(emptyenv()) : the empty environment has no parent

# view the objects saved in an environment with ls or ls.str. ls will return just 
# the object names, but ls.str will display a little about each object’s structure:

ls(emptyenv())
## character(0)

# the global environment has some familiar faces. It is where R has saved all of 
# the objects that you’ve created so far.
ls(globalenv())
##  "deal"    "deck"    "deck2"   "deck3"   "deck4"   "deck5"  
##  "die"     "gender"  "hand"    "lst"     "mat"     "mil"    
##  "new"     "now"     "shuffle" "vec"  

# use R’s $ syntax to access an object in a specific environment. 
# For example, you can access deck from the global environment:

head(globalenv()$deck, 3)
##  face   suit value
##  king spades    13
## queen spades    12
##  jack spades    11

# use the assign function to save an object into a particular environment. 
# First give assign the name of the new object (as a character string). 
# Then give assign the value of the new object, and finally the environment to 
# save the object in:

assign("new", "Hello Global", envir = globalenv())

globalenv()$new
## "Hello Global"

#### 8.2.1 The Active Environment ----


















