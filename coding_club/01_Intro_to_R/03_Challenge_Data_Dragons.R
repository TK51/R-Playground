# Dragons Challenge

#### Intro ----
# Basic Data Manipulations - Dragons Challenge
# https://ourcodingclub.github.io/tutorials/data-manip-intro/index.html
# 2023_03_30
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### The Challenge ----
# Let’s see if you can apply some of the functions we have learned today in a 
# different context. In the repository, you will find the file dragons.csv, 
# which gives the length (in cm) of the fire plumes breathed by dragons of 
# different species when fed different spices.

# Your challenge is to make the data tidy (long format) and to create a boxplot 
# for each species showing the effect of the spices on plume size, so you can 
# answer the questions: 
# - - Which spice triggers the most fiery reaction? 
# - - And the least?
  
# However, you find out that your field assistant was a bit careless during 
# data collection, and let slip many mistakes which you will need to correct.

# 1. The fourth treatment wasn’t paprika at all, it was turmeric.
# 2. There was a calibration error with the measuring device for the tabasco 
# trial, but only for the Hungarian Horntail species. All measurements are 30 cm 
# higher than they should be.
# 3. The lengths are given in centimeters, but really it would make sense to 
# convert them to meters.

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Load the elongation data
dragons <- read.csv("./datasets/dragons.csv", header = TRUE)   

#### Data exploration ----
# Check import and preview data
head(dragons)   # first few observations
str(dragons)    # types of variables
dim(dragons)    # data set dimensions

length(unique(dragons$species))  # get the number of unique dragons
unique(dragons$species)          # get the names of unique dragons


### CHANGING VARIABLE NAMES AND VALUES IN A DATA FRAME

# Create a working copy of our object
drags <- dragons

names(drags)                  # returns the names of the columns

names(drags)[6] <- "turmeric" # change the name from "paprika" to "turmeric"

# Fix the calibration error for tabasco by horntail

# create a vector of corrected values
correct.values  <- drags$tabasco[drags$species == 'hungarian_horntail'] - 30  

# overwrite the values in the dragons object
drags[drags$species == 'hungarian_horntail', 'tabasco'] <- correct.values      
head(drags)

### CREATING A FACTOR

# Let's check the classes
str(drags)

# The species column shows as characters (types), but it's really a grouping 
# factor (the species could have been called as dragons' types, etc.) Let's turn it into a factor:

drags$species <- as.factor(drags$species)    # converting and overwriting original class
str(drags)                              # now species is a factor with 3 levels

### CHANGING A FACTOR'S LEVELS

levels(drags$species)  # shows the different factor levels
# in this case there's nothing to change, but the command below could be used:
# levels(drags$species) <- c("A", "B", "C")   # you can overwrite the original levels with new names

#### TIDY DATA ----
library(tidyr)              # load the package
library(dplyr)

drags_long <- gather(drags, spice, length,                           # in this order: data frame, key, value
                          c("jalapeno", "turmeric", "tabasco", "wasabi"))        # we need to specify which columns to gather

#### SOLUTION - alternative
# Reshape the data from wide to long format

dragons_long <- gather(dragons, key = 'spice', value = 'plume', 
                       c('tabasco', 'jalapeno', 'wasabi', 'turmeric'))


head(drags_long)

boxplot(length ~ species, data = drags_long,
        xlab = "Year", ylab = "Elongation (cm)",
        main = "Annual growth of Empetrum hermaphroditum")

# Create new column with length in meters
drags_long <- mutate(drags_long, plume.m = length / 100)
head(drags_long)  # getting the length in meters

# Create a subset for each specie of dragons
unique(dragons$species)          # get the names of unique dragons

horntail <- drags_long[drags_long$species == "hungarian_horntail", ] # base R filtering
shortsnout <- filter(drags_long, species == "swedish_shortsnout")    # dplyr filtering
green <- filter(drags_long, species == "welsh_green") # the dplyr way of filtering

dim(horntail)
dim(shortsnout)
dim(green)

# Make the boxplots for each sub-set of species
boxplot(plume.m ~ spice, data = horntail,
        xlab = "Spice", ylab = "Length of fire plume, m",
        main = "Hungarian Horntail")

boxplot(plume.m ~ spice, data = green,
        xlab = "Spice", ylab = "Length of fire plume, m",
        main = "Welsh Green")

boxplot(plume.m ~ spice, data = shortsnout,
        xlab = "Spice", ylab = "Length of fire plume, m",
        main = "Swedish Shortsnout")


#### THE SOLUTION ----
## Load data

dragons <- read.csv('dragons.csv', header = TRUE)


## Clean the dataset

# Change paprika to turmeric

dragons <- rename(dragons, turmeric = paprika)


# Fix the calibration error for tabasco by horntail

correct.values  <- dragons$tabasco[dragons$species == 'hungarian_horntail'] - 30   # create a vector of corrected values

dragons[dragons$species == 'hungarian_horntail', 'tabasco'] <- correct.values      # overwrite the values in the dragons object

# to change these values after reshaping the data to long format [dplyr].
dragons.2 <- mutate(dragons, tabasco = ifelse(species == 'hungarian_horntail', 
                                              tabasco - 30, tabasco))

# This creates (overwrites) the column tabasco using the following logic: if the species is Hungarian Horntail, deduct 30 from the values in the (original) tabasco column; if the species is NOT horntail (i.e. all other species), write the original values.
# Reshape the data from wide to long format

dragons_long <- gather(dragons, key = 'spice', value = 'plume', c('tabasco', 'jalapeno', 'wasabi', 'turmeric'))


# Convert the data into meters

dragons_long <- mutate(dragons_long, plume.m = plume/100)    # Creating a new column turning cm into m


# Create a subset for each species to make boxplots

horntail <- filter(dragons_long, species == 'hungarian_horntail')            # the dplyr way of filtering
green <- filter(dragons_long, species == 'welsh_green')
shortsnout <- dragons_long[dragons_long$species == 'swedish_shortsnout', ]   # maybe you opted for a base R solution instead?


# Make the boxplots
# you need not have used this, but it splits your plotting device into 3 columns 
# where the plots will appear, so all the plots will be side by side.

par(mfrow=c(1, 3))      

  boxplot(plume.m ~ spice, data = horntail,
          xlab = 'Spice', ylab = 'Length of fire plume (m)',
          main = 'Hungarian Horntail')
  
  
  boxplot(plume.m ~ spice, data = green,
          xlab = 'Spice', ylab = 'Length of fire plume (m)',
          main = 'Welsh Green')
  
  
  boxplot(plume.m ~ spice, data = shortsnout,
          xlab = 'Spice', ylab = 'Length of fire plume (m)',
          main = 'Swedish Shortsnout')














