#### Hands-On Programming with R by Garrett Grolemund - Project 2
# Project 1: Playing Cards
# 2023_04_15
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Make a deck ----

# Working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

# Data used (as "deck")
deck <- read.csv("datasets/cards.csv")
head(deck)

#### Deal a card ----
deal <- function(cards) {
  cards[1, ]
}

deal(deck)

#### Shuffle the deck ----
shuffle <- function(cards) { 
  random <- sample(1:52, size = 52)
  cards[random, ]
}

# Deal a card
deal(deck)
## face   suit value
## king spades    13

# Shuffle a deck and deal again
deck2 <- shuffle(deck) 

deal(deck2)
## face  suit value
## jack clubs    11