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

#### 1. Downloading Shiny and tutorial resources ----
# To get Shiny in RStudio, the first thing you need is the shiny package, by 
# running the code below in RStudio:

install.packages("shiny")
install.packages("rsconnect")  # For publishing apps online
install.packages("agridat")    # For the dataset in today's tutorial