#### Preliminary set-up
# clean the slate
rm(list = ls())

#### Libraries ----
library(dplyr)  # For data manipulation
library(ggplot2)  # For data visualization

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder
magic_veg <- read.csv(file = "datasets/magic_veg.csv")

#### Data exploration ----
# We will first explore our dataset using the str() function, which shows what 
# type each variable is. What is the dataset made of?

str(magic_veg)

# land - the location within the land of magic (two possible lands: Narnia and Hogsmeade)
# plot - the plot number within each land
# year - the year the measurement was taken
# species - the species name (or code), Note that these are fake species!
# height - the imaginary canopy height at that point
# id - the id of each observation

# Let us first calculate how many species there are in each plot.

species_counts <- magic_veg %>%
  group_by(land, plot) %>%
  summarise(Species_number = length(unique(species)))

yearly_counts <- magic_veg %>%
  group_by(land, plot, year) %>%                             # We've added in year here
  summarise(Species_number = length(unique(species))) %>%
  ungroup() %>%
  mutate(plot = as.factor(plot))

# Creating your own ggplot theme ----
  # You might have noticed that the lines starting with theme() quickly pile up. 
  # We’ve been adjusting the font size of the axes and the labels, the position of 
  # the title, the background colour of the plot, etc. And then we’ve been copying 
  #and pasting those many lines of codes on all of our graphs, which really 
  # increases the length of our script, and makes our code less readable.
  
  # Here is a simple solution: create a customised theme that combines all the 
  # theme() elements you want! You can then apply it to your graphs to make things 
  # easier and increase consistency. You can include as many elements in your theme 
  # as you want, and when you apply your theme to a graph, only the relevant 
  # elements will be considered - e.g. for our histograms we won’t need to use 
# legend.position, but it’s fine to keep it in the theme in case any future 
# graphs we apply it to do have the need for legends.

theme_coding <- function(){            # creating a new theme function
  theme_bw()+                          # using a predefined theme as a base
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),       # customising lots of things
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 14),
          panel.grid = element_blank(),
          plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
          plot.title = element_text(size = 20, vjust = 1, hjust = 0.5),
          legend.text = element_text(size = 12, face = "italic"),
          legend.title = element_blank(),
          legend.position = c(0.9, 0.9))
}
# You can try out the effects of the theme by replacing all the code starting 
# with theme(........) with just theme_coding(). Look at examples 1 and 2: they 
# do the same thing, but #2 is so much easier to read!

## EXAMPLE 1: ----
# boxplot with all the theme elements specified

(boxplot <- ggplot(yearly_counts, aes(x = plot, y = Species_number, fill = land)) +
   geom_boxplot() +
   scale_x_discrete(breaks = 1:6) +
   scale_fill_manual(values = c("#deebf7", "rosybrown1"),
                     breaks = c("Narnia","Hogsmeade"),
                     name = "Land of magic",
                     labels = c("Narnia", "Hogsmeade")) +
   labs(title = "Species richness by plot", 
        x = "\n Plot number", y = "Number of species \n") + 
   theme_bw()+                          # using a predefined theme as a base
   theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),       # customising lots of things
         axis.text.y = element_text(size = 12),
         axis.title = element_text(size = 14),
         panel.grid = element_blank(),
         plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
         plot.title = element_text(size = 20, vjust = 1, hjust = 0.5),
         legend.text = element_text(size = 12, face = "italic"),
         legend.title = element_blank(),
         legend.position = c(0.9, 0.9))
)

## EXAMPLE 2: ----
# Using our custom theme to achieve the exact same thing

(boxplot <- ggplot(yearly_counts, aes(x = plot, y = Species_number, fill = land)) +
   geom_boxplot() +
   scale_x_discrete(breaks = 1:6) +
   scale_fill_manual(values = c("#deebf7", "rosybrown1"),
                     breaks = c("Narnia","Hogsmeade"),
                     name = "Land of magic",
                     labels = c("Narnia", "Hogsmeade")) +
   labs(title = "Species richness by plot", 
        x = "\n Plot number", y = "Number of species \n") + 
   theme_coding()                      # short and sweeeeet!
)


# And if you need to change some elements (like the legend that encroaches on 
# the graph here), you can simply overwrite:

(boxplot <- ggplot(yearly_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_boxplot() +
    scale_x_discrete(breaks = 1:6) +
    scale_fill_manual(values = c("#deebf7", "rosybrown1"),
                      breaks = c("Narnia","Hogsmeade"),
                      name = "Land of magic",
                      labels = c("Narnia", "Hogsmeade")) +
    labs(title = "Species richness by plot", 
         x = "\n Plot number", y = "Number of species \n") + 
    theme_coding() +                      # this contains legend.position = c(0.9, 0.9)
    theme(legend.position = "right")      # this overwrites the previous legend position setting
)
