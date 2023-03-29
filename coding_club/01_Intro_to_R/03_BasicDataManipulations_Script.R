#### Intro ----
# Basic Data Manipulations 
# https://ourcodingclub.github.io/tutorials/data-manip-intro/index.html
# 2023_03_29
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Load the elongation data
elongation <- read.csv("./datasets/EmpetrumElongation.csv", header = TRUE)   

#### Data exploration ----
# Check import and preview data
head(elongation)   # first few observations
str(elongation)    # types of variables
dim(elongation)    # data set dimensions

# Let's get some information out of this object!
elongation$Indiv   # prints out all the ID codes in the dataset
length(unique(elongation$Indiv))  # returns the number of distinct shrubs in the data

# Here's how we get the value in the second row and fifth column
elongation[2,5]

# Here's how we get all the info for row number 6
elongation[6, ]

# And of course you can mix it all together!
elongation[6, ]$Indiv   # returns the value in the column Indiv for the sixth observation
# (much easier calling columns by their names than figuring out where they are!)

# Let's access the values for Individual number 603
elongation[elongation$Indiv == 603, ]

### Using logical operators
# Subsetting with one condition

elongation[elongation$Zone < 4, ]    # returns only the data for zones 2-3
elongation[elongation$Zone <= 4, ]   # returns only the data for zones 2-3-4


# This is completely equivalent to the last statement
elongation[!elongation$Zone >= 5, ]   # the ! means exclude


# Subsetting with two conditions
elongation[elongation$Zone == 2 | elongation$Zone == 7, ]    # returns only data for zones 2 and 7
elongation[elongation$Zone == 2 & elongation$Indiv %in% c(300:400), ]    # returns data for shrubs in zone 2 whose ID numbers are between 300 and 400














