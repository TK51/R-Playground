#### Hands-On Programming with R by Garrett Grolemund - Script
# https://rstudio-education.github.io/hopr/

#### Intro ----
# Initial set-up
# 2023_04_11
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# 1. Working directory
# 2. Packages

# clean the slate and start from the clear page
rm(list = ls())
dev.off()

#### 1. Working directory ----
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/books/hands_on_programming_R")

#### 2. Downloading packages ----
install.packages("shiny")
install.packages("rsconnect")  # For publishing apps online
install.packages("agridat")    # For the dataset in today's tutorial

# Packages ----
library(shiny)  # Required to run any Shiny app
library(ggplot2)  # For creating pretty plots
library(dplyr)  # For filtering and manipulating data
library(agridat)  # The package where the data comes from
