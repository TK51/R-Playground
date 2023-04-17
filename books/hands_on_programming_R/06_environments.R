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

# use environment to see the current active environment:
environment()
## <environment: R_GlobalEnv>

#### 8.3 Scoping Rules ----
# R follows a special set of rules to look up objects. These rules are known as 
# R’s scoping rules, and you’ve already met a couple of them:
# 1. R looks for objects in the current active environment.
# 2. When you work at the command line, the active environment is the global 
# environment. Hence, R looks up objects that you call at the command line in 
# the global environment.
# Here is a third rule that explains how R finds objects that are not in the 
# active environment
# 3 .When R does not find an object in an environment, R looks in the environment’s parent environment, then the parent of the parent, and so on, until R finds the object or reaches the empty environment.

#### 8.4 Assignment ----
# When you assign a value to an object, R saves the value in the active 
# environment under the object’s name. If an object with the same name already 
# exists in the active environment, R will overwrite it.

# For example, an object named new exists in the global environment:

new
## "Hello Global"

# save a new object named new to the global environment with this command. 
# R will overwrite the old object as a result:
new <- "Hello Active"
new
## "Hello Active"

# Every time R runs a function, it creates a new active environment to evaluate 
# the function in.

#### 8.5 Evaluation ----
# R creates a new environment each time it evaluates a function. 

# use the following function to explore R’s runtime environments. We want to 
# know what the environments look like: what are their parent environments,
# and what objects do they contain? show_env is designed to tell us:
show_env <- function(){
  list(ran.in = environment(), 
       parent = parent.env(environment()), 
       objects = ls.str(environment()))
}
# show_env is itself a function, so when we call show_env(), R will create a 
# runtime environment to evaluate the function in. The results of show_env will 
# tell us the name of the runtime environment, its parent, and which objects 
# the runtime environment contains:

show_env()
## $ran.in
## <environment: 0x556b5b679688>
## 
## $parent
## <environment: R_GlobalEnv>
## 
## $objects

# if to run show_env again, the new environment will be created. R creates a new 
# environment each time you run a function. The environment is a child of the 
# global environment.

# look up a function’s origin environment by running environment on the function:
environment(show_env)
## <environment: R_GlobalEnv>

# For example, the environment of parenvs is the pryr package:
environment(parenvs)
## <environment: namespace:pryr>

# In other words, the parent of a runtime environment will not always be the 
# global environment; it will be whichever environment the function was first 
# created in.

# IMPORTANT: Any objects created by the function are stored in a safe, out-of-the-way 
# runtime environment.

# To recap, R stores its objects in an environment system. At any moment of time,
# R is working closely with a single active environment. It stores new objects 
# in this environment, and it uses the environment as a starting point when it 
# searches for existing objects. R’s active environment is usually the global 
# environment, but R will adjust the active environment to do things like run 
# functions in a safe manner.

# How can you use this knowledge to fix the deal and shuffle functions?
  
# First, let’s start with a warm-up question. Suppose I redefine deal at the 
# command line like this:
deal <- function() {
  deck[1, ]
}
# Notice that deal no longer takes an argument, and it calls the deck object, 
# which lives in the global environment.

#### Exercise 8.1 (Will deal work?) ---- 
# Will R be able to find deck and return an answer when I call the new version 
# of deal, such as deal()?
#### Solution. 
# Yes. deal will still work the same as before. R will run deal in a runtime 
# environment that is a child of the global environment. Why will it be a child 
# of the global environment? Because the global environment is the origin 
# environment of deal (we defined deal in the global environment):

environment(deal)
## <environment: R_GlobalEnv>

# When deal calls deck, R will need to look up the deck object. R’s scoping 
# rules will lead it to the version of deck in the global environment, 
# deal works as expected as a result:

deal()
##  face   suit value
##  king spades    13

# Recall that deal returns the top card of deck but does not remove the card 
# from the deck. As a result, deal always returns the same card:

deal()
##  face   suit value
##  king spades    13

deal()
##  face   suit value
##  king spades    13

# save a prisitine copy of deck and then remove the top card:
DECK <- deck

deck <- deck[-1, ]

head(deck, 3)
##  face   suit value
## queen spades    12
##  jack spades    11
##   ten spades    10

#### Exercise 8.2 (Overwrite deck) ----
# Rewrite the deck <- deck[-1, ] line of deal to assign deck[-1, ] to an object 
# named deck in the global environment. Hint: consider the assign function.
#### Solution. 
# You can assign an object to a specific environment with the assign function:
  deal <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
# Now deal will finally clean up the global copy of deck, and we can deal cards 
# just as we would in real life:
  
deal()
##  face   suit value
## queen spades    12

deal()
## face   suit value
## jack spades    11

deal()
## face   suit value
##  ten spades    10
# Let’s turn our attention to the shuffle function:
  
shuffle <- function(cards) { 
    random <- sample(1:52, size = 52)
    cards[random, ]
  }
# shuffle(deck) doesn’t shuffle the deck object; it returns a shuffled copy of the deck object:
  
head(deck, 3)
##  face   suit value
##  nine spades     9
## eight spades     8
## seven spades     7

a <- shuffle(deck)

head(deck, 3)
##  face   suit value
##  nine spades     9
## eight spades     8
## seven spades     7

head(a, 3)
##  face     suit value
##   ace diamonds     1
## seven    clubs     7
##   two    clubs     2

# This behavior is now undesirable in two ways. First, shuffle fails to shuffle deck. Second, shuffle returns a copy of deck, which may be missing the cards that have been dealt away. It would be better if shuffle returned the dealt cards to the deck and then shuffled. This is what happens when you shuffle a deck of cards in real life.

#### Exercise 8.3 (Rewrite shuffle) ----
# Rewrite shuffle so that it replaces the copy of deck that lives in the global 
# environment with a shuffled version of DECK, the intact copy of deck that also 
# lives in the global environment. The new version of shuffle should have no 
# arguments and return no output.
#### Solution. 
# You can update shuffle in the same way that you updated deck. The following 
# version will do the job:
  shuffle <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
# Since DECK lives in the global environment, shuffle’s environment of origin, 
# shuffle will be able to find DECK at runtime. R will search for DECK first in 
# shuffle’s runtime environment, and then in shuffle’s origin environment—the 
# global environment—which is where DECK is stored.

# The second line of shuffle will create a reordered copy of DECK and save it 
# as deck in the global environment. This will overwrite the previous, 
# nonshuffled version of deck.

#### 8.6 Closures ----





























