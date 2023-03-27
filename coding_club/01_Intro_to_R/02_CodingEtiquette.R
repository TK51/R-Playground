# introduction ---- 
# the "introduction ----" can be omited for clarity
# the outline is made with four "-" added after a comment
# it brings the structure to the document and afterwards can be seen
# in the outline pane switched in the upper right corner ob by
# hitting "Ctrl + Shift + O"

# the beginning ----
# get and set the working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/coding_club")

# some outline ----

# the basic script structure ----
# - the introduction
# - libraries
# - functions
# - working directory
# - loaded data
# - The different sections of your analysis: logical development

####################################################################
# examples ----


# intro ---- (the inscription itself can be omitted for clarity)

# Analyzing vertebrate population change based on the 
# Living Planet Index
# Data available from http://www.livingplanetindex.org/

# Gergana Daskalova ourcodingclub(at)gmail.com
# 25-04-2017

# Libraries ---- listing the used packages
library(tidyr)  # Formatting data for analysis
library(dplyr)  # Manipulating data
library(ggplot2)  # Visualizing results
library(readr)  # Manipulating data

# Defining functions ---- listing the functions used
# A custom ggplot2 function
theme.LPI <- function(){
  theme_bw()+
    theme(axis.text.x=element_text(size=12, angle=45, vjust=1, hjust=1),
          axis.text.y=element_text(size=12),
          axis.title.x=element_text(size=14, face="plain"),             
          axis.title.y=element_text(size=14, face="plain"),             
          panel.grid.major.x=element_blank(),                                          
          panel.grid.minor.x=element_blank(),
          panel.grid.minor.y=element_blank(),
          panel.grid.major.y=element_blank(),  
          plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
          plot.title = element_text(size=20, vjust=1, hjust=0.5),
          legend.text = element_text(size=12, face="italic"),          
          legend.title = element_blank(),                              
          legend.position=c(0.9, 0.9))
}

# working directory ---- set up moments
# Set the working directory on Windows ---- ...
setwd("D:/Work/coding_club/CC-etiquette-master")

# Set the working directory on Mac/Linux ---- ...
setwd("~/Work/coding_club/CC-etiquette-master")

# Import data ---- data used 
LPI <- read.csv("/home/t51/DataAnalytics/R-Playground/coding_club/datasets/LPIdata_CC.csv")

# Formatting data ----
LPI2 <- gather(LPI, "year", "abundance", 9:53)  # Transforming the data from wide to long format, some blank cells may disappear
# gather function requires tidyr package
LPI2$year <- parse_number(LPI2$year)  # Do you see awkward Xs before all the years? This gets rid of them.
names(LPI2)  # Check what the different variables are called
names(LPI2) <- tolower(names(LPI2))  # Make all variable names lower case

# When manipulating data it's always good check if the variables have stayed how we want them
# Use the str() function
str(LPI2)

# Abundance is a character variable, when it should be numeric, let's fix that
LPI2$abundance <- as.numeric(LPI2$abundance)

# Calc summary stats for each biome in the LPI database ----
levels(LPI2$biome)  # list all biomes

LPI_biome_summ <- LPI2 %>%  # use of pipe operator
  group_by(biome) %>%  # Group by biome
  summarise(populations = n())  # Create columns, number of populations

# Visualising the number of populations in each biome with ggplot2 package ---- 
(barplot <- ggplot(LPI_biome_summ, aes(biome, color = biome, y = populations)) + geom_bar(stat = "identity") +  
   theme.LPI() +                     # Use of personal theme function
   ylab("Number of populations") +
   xlab("Biome") +
   theme(legend.position = "none"))  # Removal of legend for simplicity

# Note that putting your entire ggplot code in brackets () creates the graph 
# and then shows it in the plot viewer. If you don’t have the brackets, you’ve 
# only created the object, but haven’t visualized it. You would then have to 
# call the object such that it will be displayed by just typing "barplot" after 
# you’ve created the “barplot” object.


# shortcuts ----
# - Ctrl + Shift + O - outline pane
# - Alt + L - collapse
# - Alt + Shift + L - expand
# - Alt + O - collapse all
# - Alt + Shift + O - expand all
