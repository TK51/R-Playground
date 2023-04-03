#  Challenge yourself!

# TASK ---
# To practice making graphs, go back to the original LPI dataset that you 
# imported at the beginning of the tutorial. Now, can you:
  
#  1 - Choose TWO species from the LPI data and display their population trends 
# over time, using a scatterplot and a linear model fit?
  
#  2 - Using the same two species, filter the data to include only records from 
# FIVE countries of your choice, and make a boxplot to compare how the abundance 
# of those two species varies between the five countries?

# clear the slate
rm(list = ls())

#### Libraries ----
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(gridExtra)
library(egg) # lines up plots together regardless of whether they have a legend or not

# colourpicker can be used via install.packages("colourpicker")
library(colourpicker)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder
LPI <- read.csv("datasets/LPIdata_CC.csv")

# Reshape data into long form
# By adding 9:53, we select columns 9 to 53, the ones for the different years of monitoring
LPI2 <- gather(LPI, "year", "abundance", 9:53)

# SOLUTION ----

# two Arctic animals are chosen
arctic <- filter(LPI2, Common.Name %in% c('Reindeer / Caribou', 'Beluga whale'))
dim(arctic)
arctic <- na.omit(arctic)
dim(arctic)

# GRAPH 1 - POPULATION CHANGE OVER TIME

(arctic.scatter<- ggplot(arctic, aes(x = year, y = abundance)) +
    geom_point(aes(colour = Country.list), size = 1.5, alpha = 0.6) +                # alpha controls transparency
    facet_wrap(~ Common.Name, scales = 'free_y') +                                   # facetting by species
    stat_smooth(method = 'lm', aes(fill = Country.list, colour = Country.list)) +    # colour coding by country
    scale_colour_manual(values = c('#8B3A3A', '#4A708B', '#FFA500', '#8B8989'), name = 'Country') +
    scale_fill_manual(values = c('#8B3A3A', '#4A708B', '#FFA500', '#8B8989'), name = 'Country') +
    labs(x = 'Year', y = 'Abundance \n') +
    theme_bw() +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size = 10),
          axis.text = element_text(size = 10),
          axis.title = element_text(size = 10),
          legend.text = element_text(size = 10),
          legend.title = element_text(size = 10))
)

# GRAPH 2 - BOXPLOTS OF ABUNDANCE ACROSS FIVE COUNTRIES

# Only have four countries so no subsetting; let's plot directly:
(arctic.box <- ggplot(arctic, aes(x = Country.list, y = abundance)) +
    geom_boxplot() +
    labs(x = 'Country', y = 'Abundance \n') +
    theme_bw() +
    facet_wrap(~Common.Name, scales = 'free_y') +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size = 12),
          axis.text = element_text(size = 12),
          axis.title = element_text(size = 12),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 12))
)

# Not great because of high-abundance outliers for reindeer in Canada - let's remove them for now (wouldn't do that for an analysis!)
(arctic.box <- ggplot(filter(arctic, abundance < 8000), aes(x = Country.list, y = abundance)) +
    geom_boxplot() +
    labs(x = 'Country', y = 'Abundance \n') +
    theme_bw() +
    facet_wrap(~Common.Name, scales = 'free_y') +
    theme(panel.grid = element_blank(),
          strip.background = element_blank(),
          strip.text = element_text(size = 12),
          axis.text = element_text(size = 12),
          axis.text.x = element_text(angle = 45, hjust = 1),
          axis.title = element_text(size = 12))
)

#Align together in a panel - here I use the egg package that lines up plots together regardless of whether they have a legend or not

ggarrange(arctic.scatter + labs(title = 'Population change over time'), 
          arctic.box + labs(title = 'Population size across countries'))

# Graphs DESCRIPTION
# Population trends and abundance of two Arctic species across their range 
# according to the LPI dataset.
