#### BDATA VISUALISATION 2 - Script

#### Intro ----
# CUSTOMISING YOUR FIGURES - Data visualization tutorial
# Vegetation of magical lands
# https://ourcodingclub.github.io/tutorials/data-vis-2/index.html
# 2023_04_04
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# 1. Customize histograms in ggplot2
# --- Add titles, subtitles, captions and axis labels
# --- Change the plot background
# --- Fix the legend and customize colours
# 2. Create your own colour palette
# 3. Customize boxplots in ggplot2
# 4. Add regression lines to your plots
# 5. Create your own ggplot theme
# 6. Challenge yourself!

# clean the slate
rm(list = ls())

#### Libraries ----
library(dplyr)  # For data manipulation
library(ggplot2)  # For data visualisation

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder
magic_veg <- read.csv(file = "datasets/magic_veg.csv")

#### Data explaration ----
# We will first explore our dataset using the str() function, which shows what 
# type each variable is. What is the dataset made of?
  
str(magic_veg)

# land - the location within the land of magic (two possible lands: Narnia and Hogsmeade)
# plot - the plot number within each land
# year - the year the measurement was taken
# species - the species name (or code), Note that these are fake species!
# height - the imaginary canopy height at that point
# id - the id of each observation

dim(magic_veg)
head(magic_veg)

#### 1. Customise histograms in ggplot ----
# We’ll start by revisiting some of the types of plots we can make with ggplot2. 
# Let us first calculate how many species there are in each plot.

species_counts <- magic_veg %>%
  group_by(land, plot) %>%
  summarise(Species_number = length(unique(species)))
# Using what we’ve learnt from our previous data visualization tutorial, 
# we run the following code to create a histogram.

(hist <- ggplot(species_counts, aes(x = plot)) +
    geom_histogram())
# Note that putting your entire ggplot code in brackets () creates the graph 
# and then shows it in the plot viewer. 

# This is the common way of making a histogram, when you have one observation 
# per row and the histogram tallies them for you. But you can immediately see 
# that it doesn’t look right, because we are working with summarized data. 
# You therefore need to tell R that you already know how many species are in 
# each plot. You do that by specifying the stat argument:

(hist <- ggplot(species_counts, aes(x = plot, y = Species_number)) +
    geom_histogram(stat = "identity"))

# Note: an equivalent alternative is to use geom_col (for column), 
# which takes a y value and displays it
(col <- ggplot(species_counts, aes(x = plot, y = Species_number)) +
    geom_col()
)

# That looks a bit better, but it still seems to have far too many species. 
# That’s because plots from each land are being grouped together. We can separate 
# them by introducing a colour code, and make a stacked bar plot like this:
  
(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity"))

# Remember that any aesthetics that are a function of your data (like fill here) 
# need to be INSIDE the aes() brackets.




















