#### EFFICIENT DATA MANIPULATION - Script

#### Intro ----
# USE PIPES TO STREAMLINE YOUR CODE
# https://ourcodingclub.github.io/tutorials/data-manip-efficient/index.html
# 2023_04_03
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----

# Tutorial AIMS:
# 1. Chain together multiple lines of codes with pipes %>%
# 2. Use dplyr to its full potential
# 3. Automate advanced tasks like plotting without writing a loop

# Tutorial STEPS
# 1. An introduction to pipes
# 2. Discover more functions of dplyr
# --- summarise_all()
# --- case_when()
# 3. Rename and reorder factor levels or create categorical variables
# 4. Advanced piping
# 5. Challenge yourself!

#### Libraries ----
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(gridExtra)

# colourpicker can be used via install.packages("colourpicker")
library(colourpicker)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder