#### Intro ----
# Basic Data Manipulations 
# https://ourcodingclub.github.io/tutorials/modelling/index.html
# 2023_03_31
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# Here, a few different types of models are to be explored. 
# The work starts with a sample dataset about apple yield in relation to 
# different factors. The dataset is part of the agridat package.

#### Libraries ----
install.packages("agridat")
library(agridat)
library(ggplot2)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from agridat
apples <- agridat::archbold.apple
dim(apples)
head(apples)
str(apples)
summary(apples)

#### Data exploration ----
# Check the data by visualizing it

# first, define a ggplot2 theme for creation of consistent graph formatting
theme.clean <- function() {
  theme_bw()+
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),
          axis.text.y = element_text(size = 12),
          axis.title.x = element_text(size = 14, face = "plain"),             
          axis.title.y = element_text(size = 14, face = "plain"),             
          panel.grid.major.x = element_blank(),                                          
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_blank(),  
          plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
          plot.title = element_text(size = 20, vjust = 1, hjust = 0.5),
          legend.text = element_text(size = 12, face = "italic"),          
          legend.position = "right")
}

# make a boxplot to examine the data
# idea - see the the influence of distance between trees to the yield cropped

apples$spacing2 <- as.factor(apples$spacing) # set spacing int as factor
# This turns the previously numeric spacing variable into a 3-level categorical 
# variable, with 6, 10 and 14 being the levels.

(apples.p <- ggplot(apples, aes(spacing2, yield)) +
    geom_boxplot(fill = "#CD3333", alpha = 0.8, colour = "#8B2323") +
    theme.clean() +  
    theme(axis.text.x = element_text(size = 12, angle = 0)) +
    labs(x = "Spacing (m)", y = "Yield (kg)"))

apples.p  # call the object to visualize the plot

# From the boxplot, we can see that yield is pretty similar across the different 
# spacing distances. Even though there is a trend towards higher yield at higher 
# spacing, the range in the data across the categories almost completely overlap. 
# From looking at this boxplot alone, one might think our hypothesis of higher 
# yield at higher spacing is not supported. 

#Let’s run a model to explicitly test this.
apples.m <- lm(yield ~ spacing2, data = apples)
summary(apples.m)






















