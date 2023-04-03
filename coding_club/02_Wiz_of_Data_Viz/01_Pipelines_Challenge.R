# Challenge yourself! ----

#### TASK ----
# The Craigmillar Castle team would like a summary of the different species 
# found within its grounds, but broken down in four quadrants (NE, NW, SE, SW). 
# You can start from the trees.genus object created earlier.

# 1. Can you calculate the species richness (e.g. the number of different species) 
# in each quadrant?
# 2. They would also like to know how abundant the genus Acer is (as a % of the 
# total number of trees) in each quadrant.
# 3. Finally, they would like, for each quadrant separately, a bar plot showing 
# counts of Acer trees in the different age classes, ordered so they read from 
# Young (lumping together juvenile and semi-mature trees), Middle Aged, and Mature.

# clear the slate
rm(list = ls())

#### Libraries ----
library(ggplot2)
library(tidyr)
library(dplyr)

#### Working directory ----
# Set working directory
getwd()
setwd(".coding_club")

#### Data source ----
# Loading the dataset from dataset folder
trees <- read.csv(file = "datasets/trees.csv", header = TRUE)

# trees.genus object ----
# creating the trees.genus object  for challenge purposes

# checking the names in Latin
unique(trees$LatinName)  # Shows all the species names =LatinName

# Create a new column with the tree genera
trees.genus <- trees %>%
  mutate(Genus = case_when(               # creates the genus column and specifies conditions
    grepl("Acer", LatinName) ~ "Acer",
    grepl("Fraxinus", LatinName) ~ "Fraxinus",  # finds pattern and names after it
    grepl("Sorbus", LatinName) ~ "Sorbus",
    grepl("Betula", LatinName) ~ "Betula",
    grepl("Populus", LatinName) ~ "Populus",
    grepl("Laburnum", LatinName) ~ "Laburnum",
    grepl("Aesculus", LatinName) ~ "Aesculus",
    grepl("Fagus", LatinName) ~ "Fagus",
    grepl("Prunus", LatinName) ~ "Prunus",
    grepl("Pinus", LatinName) ~ "Pinus",
    grepl("Sambucus", LatinName) ~ "Sambucus",
    grepl("Crataegus", LatinName) ~ "Crataegus",
    grepl("Ilex", LatinName) ~ "Ilex",
    grepl("Quercus", LatinName) ~ "Quercus",
    grepl("Larix", LatinName) ~ "Larix",
    grepl("Salix", LatinName) ~ "Salix",
    grepl("Alnus", LatinName) ~ "Alnus")
  )

unique(trees.genus$Genus)  # Shows all the Genus names =Genus

# SOLUTION ----

# First of all, we need to create the four quadrants. 
# This only requires simple maths and the use of mutate to create a new factor.

## 1. Calculate the quadrants ----

# Find the center coordinates that will divide the data (adding half of the 
# range in longitude and latitude to the smallest value)

lon <- (max(trees.genus$Easting) - min(trees.genus$Easting))/2 + min(trees.genus$Easting)
lat <- (max(trees.genus$Northing) - min(trees.genus$Northing))/2 + min(trees.genus$Northing)

# Create the column

trees.genus <- trees.genus %>%
  mutate(Quadrant = case_when(
    Easting < lon & Northing > lat ~ 'NW',
    Easting < lon & Northing < lat ~ 'SW',
    Easting > lon & Northing > lat ~ 'NE',
    Easting > lon & Northing < lat ~ 'SE')
  )

# We can check that it worked
ggplot(trees.genus) +
  geom_point(aes(x = Easting, y = Northing, colour = Quadrant)) +
  theme_bw()
# It did work, but there is a NA value (check the legend)! Probably this point 
# has the exact integer value of middle Easting, and should be attributed to 
# one side or the other (your choice).

#
trees.genus <- trees.genus %>%
  mutate(Quadrant = case_when(
    Easting <= lon & Northing > lat ~ 'NW',  # using inferior OR EQUAL ensures that no point is forgotten
    Easting <= lon & Northing < lat ~ 'SW',
    Easting > lon & Northing > lat ~ 'NE',
    Easting > lon & Northing < lat ~ 'SE')
  )
# To answer the first question, a simple pipeline combining group_by() and 
# summarise() is what we need.

#
sp.richness <- trees.genus %>%
  group_by(Quadrant) %>%
  summarise(richness = length(unique(LatinName)))

#There we are! We have 7, 15, 8 and 21 species for the NE, NW, SE, and SW 
# corners respectively!
  
#There are different ways to calculate the proportion of Acer trees, here is 
# one (maybe base R would have been less convoluted in this case!):
  
#
acer.percent <- trees.genus %>%
  group_by(Quadrant, Genus) %>%
  tally() %>%                      # get the count of trees in each quadrant x genus
  group_by(Quadrant) %>%           # regroup only by quadrant
  mutate(total = sum(n)) %>%       # sum the total of trees in a new column
  filter(Genus == 'Acer') %>%      # keep only acer
  mutate(percent = n/total)        # calculate the proportion
  

# We can make a plot representing the %

ggplot(acer.percent) +
  geom_col(aes(x = Quadrant, y = percent, fill = Quadrant)) +
  labs(x = 'Quadrant', y = 'Proportion of Acer') +
  theme_bw()
# And finally, we can use our manipulation skills to subset the data frame to Acer
# only and change the age factor, and then use our pipes to create the four plots.


# Create an Acer-only data frame

acer <- trees.genus %>%
  filter(Genus == 'Acer')


# Rename and reorder age factor

acer$AgeGroup <- factor(acer$AgeGroup,
                        levels = c('Juvenile', 'Semi-mature', 'Middle Aged', 'Mature'),
                        labels = c('Young', 'Young', 'Middle Aged', 'Mature'))


# Plot the graphs for each quadrant

acer.plots <- acer %>%
  group_by(Quadrant) %>%
  do(plots =           # the plotting call within the do function
       ggplot(data = .) +
       geom_bar(aes(x = AgeGroup)) +
       labs(title = paste('Age distribution of Acer in ', .$Quadrant, ' corner', sep = ''),
            x = 'Age group', y = 'Number of trees') +
       theme_bw() +
       theme(panel.grid = element_blank(),
             axis.title = element_text(size = 14),
             axis.text = element_text(size = 14),
             plot.title = element_text(hjust = 0.5))
  )

# View the plots (use the arrows on the Plots viewer)
acer.plots$plots






















