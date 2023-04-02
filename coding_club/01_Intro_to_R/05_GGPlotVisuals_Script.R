#### BEAUTIFUL AND INFORMATIVE DATA VISUALISATION - Script

#### Intro ----
# USING GGPLOT2 TO COMMUNICATE YOUR RESULTS
# https://ourcodingclub.github.io/tutorials/datavis/index.html
# 2023_04_02
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# 1. Get familiar with the ggplot2 syntax
# 2. Decide on the right type of plot
# --- Distribution: histogram, density, boxplot
# --- Comparison: boxplot, bar plot, dot plot
# --- Relationship: scatter plot
# 3. Practice making different plots with ggplot2
# --- Histograms
# --- Scatter plots
# --- Box plots
# --- Bar plots
# 4. Learn to arrange graphs in a panel and to save files
# 5. Challenge yourself!

#### Libraries ----
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(gridExtra)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder
LPI <- read.csv("datasets/LPIdata_CC.csv")

#### Data exploration ----
dim(LPI)
head(LPI)
str(LPI)

# The data are in wide format - the different years are column names, when 
# really they should be rows in the same column. 
# We will reshape the data using the gather() function from the tidyr package

# Reshape data into long form
# By adding 9:53, we select columns 9 to 53, the ones for the 
# different years of monitoring
LPI2 <- gather(LPI, "year", "abundance", 9:53)
View(LPI2)

# There is an ‘X’ in front of all the years because when we imported the data, 
# all column names became characters. 
# (The X is R’s way of turning numbers into characters.) 
# Now that the years are rows, not columns, we need them to be proper numbers, 
# so we will transform them using parse_number() from the readr package


















