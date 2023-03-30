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

### USING LOGICAL OPERATORS
# Subsetting with one condition

elongation[elongation$Zone < 4, ]    # returns only the data for zones 2-3
elongation[elongation$Zone <= 4, ]   # returns only the data for zones 2-3-4


# This is completely equivalent to the last statement
elongation[!elongation$Zone >= 5, ]   # the ! means exclude


# Subsetting with two conditions
elongation[elongation$Zone == 2 | elongation$Zone == 7, ]    # returns only data for zones 2 and 7
elongation[elongation$Zone == 2 & elongation$Indiv %in% c(300:400), ]  # returns data for shrubs in zone 2 whose ID numbers are between 300 and 400

# Other useful vector sequence builders are:
seq(300, 400, 10)       # makes 300 310 320 330 ... 400
rep(c(1,2), 3)          # makes 1 2 1 2 1 2
rep(seq(0, 30, 10), 3)  # makes 0 10 20 30  0 10 20 30  0 10 20 30 


### CHANGING VARIABLE NAMES AND VALUES IN A DATA FRAME

# Let's create a working copy of our object
elong2 <- elongation

# Now suppose you want to change the name of a column: you can use the  names() function
# Used on its own, it returns a vector of the names of the columns. 
# Used on the left side of the assign arrow, it overwrites all or some of the names to value(s) of your choice.

names(elong2)                 # returns the names of the columns

names(elong2)[1] <- "zone"    # Changing Zone to zone: we call the 1st element of the names vector using brackets, and assign it a new value
names(elong2)[2] <- "ID"      # Changing Indiv to ID: we call the 2nd element and assign it the desired value

# Now suppose there's a mistake in the data, and the value 5.1 for individual 373 in year 2008 should really be 5.7

## - option 1: you can use row and column number
elong2[1,4] <- 5.7

## - option 2: you can use logical conditions for more control
elong2[elong2$ID == 373, ]$X2008 <- 5.7   # completely equivalent to option 1


## CREATING A FACTOR

# Let's check the classes
str(elong2)

# The zone column shows as integer data (whole numbers), but it's really a grouping factor (the zones could have been called A, B, C, etc.) Let's turn it into a factor:

elong2$zone <- as.factor(elong2$zone)    # converting and overwriting original class
str(elong2)                              # now zone is a factor with 6 levels


## CHANGING A FACTOR'S LEVELS

levels(elong2$zone)  # shows the different factor levels

levels(elong2$zone) <- c("A", "B", "C", "D", "E", "F")   # you can overwrite the original levels with new names

# You must make sure that you have a vector the same length as the number of factors, and pay attention to the order in which they appear!

#### TIDY DATA, and how do we achieve it? ----

install.packages("tidyr")  # install the package
library(tidyr)             # load the package


elongation_long <- gather(elongation, Year, Length,                           # in this order: data frame, key, value
                          c(X2007, X2008, X2009, X2010, X2011, X2012))        # we need to specify which columns to gather

# Here we want the lengths (value) to be gathered by year (key)

# Let's reverse! spread() is the inverse function, allowing you to go from long to wide format
elongation_wide <- spread(elongation_long, Year, Length)

# having numerous columns, column number also can be used
elongation_long2 <- gather(elongation, Year, Length, c(3:8))
head(elongation_long2)



















