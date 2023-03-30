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

names(drags)[6] <- "turmeric" # change the name from "paprika" to "turnmeric"

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





# for the tabasco 
# trial, but only for the Hungarian Horntail species. All measurements are 30 cm 
# higher than they should be.

# 3. The lengths are given in centimeters, but really it would make sense to 
# convert them to meters.















