# introduction ---- 
# the "introduction ----" can be omitted for clarity
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
# - the different sections of your analysis: logical development
# - the outputs of your analysis

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

# The outputs of your analysis ----
# Remember to keep your filepath sensible not only when loading data in, but 
# also when you are outputting files (e.g. .Rdata, .csv files and any figures 
# you want saved). .csv files are more transferable and can be used across 
# multiple platforms, whereas .Rdata files are more compressed and are quicker 
# to work with. Saving graphs as .pdf files is better practice, since .pdf 
# files are vector based and don’t decrease in quality when you zoom in or out. 
# .png files, on the other hand, are easily inserted in text documents and 
# presentations, so ideally you should save a .pdf and a .png file of your 
# graph. It is also good practice to save image outputs in a subdirectory of 
# your working directory, e.g. img/. Remember that you will have to create the 
# folder img manually before saving plots to it:
  
png(file="img/biome_pop.png", 
    width = 1000, height = 2000)  # Note that png() uses pixel values for width and height
ggplot(LPI_biome_summ, aes(biome, color = biome, y = populations)) + geom_bar(stat = "identity") +
  theme.LPI() +
  ylab("Number of populations") +
  xlab("Biome") +
  theme(legend.position = "none")
dev.off()  # This tells R you are done with the plotting and it can save the file

pdf(file="img/biome_pop.pdf",  width = 13.33, height = 26.66)  # pdf() uses inches
ggplot(LPI_biome_summ, aes(biome, color = biome, y = populations)) + geom_bar(stat = "identity") +
  theme.LPI() +
  ylab("Number of populations") +
  xlab("Biome") +
  theme(legend.position = "none")
dev.off()

# file naming ----
# -- Object names should be concise and meaningful.Long object names are annoying 
# to type. More letters = higher chance you’ll make a typo.
# -- Variable names should be nouns. e.g. abundance richness
# -- Function names should be verbs. e.g. calc.sp.richness
# -- Use an underscore to separate words within a script file. e.g. 
# LPI_analysis_Apr_2017.R
# -- The preferred form for object/variable names is all lower case letters 
# and words separated with underscores e.g. (object_name$variable_name).
# -- For functions, all lower case letters and words separated by dots e.g. 
# (function.name).

# - example: Object names
avg_clicks  # Good.
avg.clicks  # Acceptable.
avg_Clicks  # Not okay.

# - example: Function names
calculate.avg.clicks  # This is what we are aiming for.
CalculateAvgClicks  # Not that bad, but mixing capital and lowercase letters 
# can lead to typos
calculate_avg_clicks, calculateAvgClicks  # Bad. The convention is that 
# functions are defined using dots, not underscores.

# spacing ----
# -- Place spaces around all infix operators (=, +, -, <-, etc.). The same rule 
# applies when using = in function calls. Always put a space after a comma, 
# and never before, just like in normal prose.
# -- Don’t place a space before left parentheses, except in a function call.
# -- Extra spacing (i.e., more than one space in a row) is ok if it improves 
# alignment of equal signs or assignments (<-).
# -- Do not place spaces around code in parentheses or square brackets (unless 
# there’s a comma, in which case see above).
# -- Inline commenting: If you are commenting inline with code, place two spaces
# after the code, followed by #, a single space and then your text, e.g. 
# summary(model)<space><space>#<space>comment.

# curly braces ----
# -- An opening curly brace should never go on its own line and should always 
# be followed by a new line. A closing curly brace should always go on its own 
# line, unless it’s followed by else. Always indent the code inside curly braces.

# line length ----
# -- The official convention is to limit your code to 80 characters per line. 
# -- How do you know what’s 80 characters though? RStudio can place a handy line 
# in your editor as a reminder! Go to 
# Tools/Global Options/Code/Display/Show Margin/80 characters. 
# -- When using pipes from the dplyr package, keep the pipe operator %>% at the 
# end of the line and continue your pipe on a new line.
# -- When using ggplot2, keep the + at the end of the line and continue 
# adding on layers on a new line.

# shortcuts ----
# - Ctrl + Shift + O - outline pane
# - Alt + L - collapse
# - Alt + Shift + L - expand
# - Alt + O - collapse all
# - Alt + Shift + O - expand all
