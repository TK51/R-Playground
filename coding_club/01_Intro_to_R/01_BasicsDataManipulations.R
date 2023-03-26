##### CODING CLUB Workshop 1 - R Basics #######################################
# Learning how to import and explore data, and make graphs

### CREATE WORKING DIRECTORY ##################################################
# create folder for Coding Club activities - remove the hash below to execute
#dir.create("/home/t51/DataAnalytics/R-Playground/coding_club")

# set the working directory to coding_club/01_Intro_to_R folder
setwd("/home/t51/DataAnalytics/R-Playground/coding_club/01_Intro_to_R")

# check if everything worked well with directory set-up
getwd()

### INSTALL PACKAGES ##########################################################
# start with dplyr
install.packages("dplyr")
library(dplyr)

### IMPORT and CHECK DATA #####################################################
edidiv <- read.csv("/home/t51/DataAnalytics/R-Playground/coding_club/datasets/edidiv.csv")

# check that the data was imported without any mistakes
head(edidiv) # displays the first few rows
tail(edidiv) # displays the last few rows
str(edidiv) # see the variables types: continuous, integers, categorical, chars

# notice, that taxonGroup is a character, it should be a factor (categorical)
head(edidiv$taxonGroup) # displays the first few rows of a single column
class(edidiv$taxonGroup) # check the variable type (character, factor, integer)

edidiv$taxonGroup <- as.factor(edidiv$taxonGroup)
str(edidiv$taxonGroup)

# make some more explorations
dim(edidiv) # displays the number of rows and columns
summary(edidiv) # gives a summary of the data
summary(edidiv$taxonGroup) # gives a summary of particular variable
table(edidiv$taxonGroup) # =summary(edidiv$taxonGroup) # gives summary

### CALCULATE SPECIES RICHNESS ################################################
# dplyr should be installed and engaged

# split dataset into multiple objects by filtering the data [filter() @ dplyr]
# remind the names in taxa group
summary(edidiv$taxonGroup)

# filter the Beetles
Beetle <- filter(edidiv, taxonGroup == 'Beetle')
# first goes the data frame, second - condition to filter on, meaning:
# the variable taxonGroup MUST BE EXACTLY (==) Beetle, else is dropted... 

# filter the Birds out
Bird <- filter(edidiv, taxonGroup == 'Bird')

# filter the rest of the taxa one-by-one
Butterfly <- filter(edidiv, taxonGroup == 'Butterfly')
Dragonfly <- filter(edidiv, taxonGroup == 'Dragonfly')
Flowering.Plants <- filter(edidiv, taxonGroup == 'Flowering.Plants')
Fungus <- filter(edidiv, taxonGroup == 'Fungus')
Hymenopteran <- filter(edidiv, taxonGroup == 'Hymenopteran')
Lichen <- filter(edidiv, taxonGroup == 'Lichen')
Liverwort <- filter(edidiv, taxonGroup == 'Liverwort')
Mammal <- filter(edidiv, taxonGroup == 'Mammal')
Mollusc <- filter(edidiv, taxonGroup == 'Mollusc')

# calculate the species richness by using both unique() and length() functions
# unique() - identifies different species, length() - counts them
a <- length(unique(Beetle$taxonName))
b <- length(unique(Bird$taxonName))
c <- length(unique(Butterfly$taxonName))
d <- length(unique(Dragonfly$taxonName))
e <- length(unique(Flowering.Plants$taxonName))
f <- length(unique(Fungus$taxonName))
g <- length(unique(Hymenopteran$taxonName))
h <- length(unique(Lichen$taxonName))
i <- length(unique(Liverwort$taxonName))
j <- length(unique(Mammal$taxonName))
k <- length(unique(Mollusc$taxonName))

# check the results by getting list of values
c(a, b, c, d, e, f, g, h, i, j, k)

### CREATE a VECTOR and PLOT IT ##############################################
# put together all the values 
biodiv <- c(a, b, c, d, e, f, g, h, i, j, k)
# pay attention to the object names calculated and their order
names(biodiv) <- c("Beetle",
                   "Bird",
                   "Butterfly",
                   "Dragonfly",
                   "Flowering.Plants",
                   "Fungus",
                   "Hymenopteran",
                   "Lichen",
                   "Liverwort",
                   "Mammal",
                   "Mollusc")

# now, visualize the species richness with the barplot() function
barplot(biodiv)

# use help function to get the understanding of available features 
help(barplot) # for help with the barplot() function
help(par) # for help with plotting in general

### MAKE a PROPER PLOT #######################################################
# save file by wrapping the code in the png() and dev.off() functions
png("barplot.png", width = 1600, height = 600)
barplot(biodiv, xlab = "Taxa", ylab = "Number of Species", ylim = c(0, 600),
        cex.names = 1.2, cex.axis = 1.5, cex.lab = 1.2)
dev.off()

# the cex code increases the font size when <1 and decreases >1
# cex.names	- expansion factor for axis names (bar labels).
# cex.axis -	expansion factor for numeric axis labels (see par('cex')).

### CREATE a DATA FRAME and PLOT IT ##########################################
# - data frames are tables of values with two-dimensional structure
# - each column can have a different data type

# safe the new object into a separate data frame as a new .csv file
# there will be a data frame with species richness data saved using write.csv()

# create an object containing all taxa names (one column) and another object
# with all the values for the species richness of each taxon (another column)

# creating an object called "taxa" that contains all the taxa names
taxa <- c("Beetle",
          "Bird",
          "Butterfly",
          "Dragonfly",
          "Flowering.Plants",
          "Fungus",
          "Hymenopteran",
          "Lichen",
          "Liverwort",
          "Mammal",
          "Mollusc")

# turning this object into a factor, i. e. a categorical variable
taxa_f <- factor(taxa)

# combining all the values for the number of species in "richness" object
richness <- c(a, b, c, d, e, f, g, h, i, j, k)

# creating the data frame from the two vectors
biodata <- data.frame(taxa_f, richness)
biodata

# saving the file
write.csv(biodata, file = "biodata.csv") # it is saved in the working directory

# create and save the plot using the data frame
png("barplot2.png", width = 1600, height = 600)
barplot(biodata$richness, names.arg = c("Beetle",
                                        "Bird",
                                        "Butterfly",
                                        "Dragonfly",
                                        "Flowering.Plants",
                                        "Fungus",
                                        "Hymenopteran",
                                        "Lichen",
                                        "Liverwort",
                                        "Mammal",
                                        "Mollusc"),
        xlab = "Taxa", ylab = "Number of Species", ylim = c(0,600))
dev.off()

##### CHALLENGE ##############################################################
bird_sp <- c("sparrow",
             "kingsfisher",
             "eagle",
             "hummingbird",
             "sparrow",
             "kingsfisher",
             "eagle",
             "hummingbird",
             "sparrow",
             "kingsfisher",
             "eagle",
             "hummingbird")
wingspan <- c(22, 26, 195, 8, 24, 23, 201, 9, 21, 25, 185, 9)
wings <- data.frame(bird_sp, wingspan)
wings
# TASK: produce a bar plot of the mean wingspan and save it to computer

# calculate the mean for each bird
sparrow <- filter(wings, bird_sp == "sparrow") 
sparrow
sparrow <- mean(sparrow$wingspan)
sparrow

kingsfisher <- filter(wings, bird_sp == "kingsfisher") 
kingsfisher
kingsfisher <- mean(kingsfisher$wingspan)
kingsfisher

eagle <- filter(wings, bird_sp == "eagle") 
eagle
eagle <- mean(eagle$wingspan)
eagle

hummingbird <- filter(wings, bird_sp == "hummingbird") 
hummingbird
hummingbird <- mean(hummingbird$wingspan)
hummingbird

# put the means together as vector in a mean dataset, match the order carefully
wingspan <- c(sparrow, kingsfisher, eagle, hummingbird)
bird_sp <- c("sparrow", "kingsfisher", "eagel", "hummingbird")
bird_sp <- as.factor(bird_sp)

# combine two vectors into a single data frame
wings <- data.frame(bird_sp, wingspan)

# check if the data frame works
barplot(wings$wingspan)
dev.off()

# plot the bar & save it to a file
png("mean_wingspan.png", width = 800, height = 600)
barplot(wings$wingspan, names.arg = wings$bird_sp,
        xlab = "Bird species",
        ylab = "Average winspan (cm)",
        ylim = c(0, 200),
        col = "pink")
dev.off()

##### WELL DONE!


