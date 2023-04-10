#### EFFICIENT DATA MANIPULATION - Script

#### Intro ----
# USE PIPES TO STREAMLINE YOUR CODE
# https://ourcodingclub.github.io/tutorials/data-manip-efficient/index.html
# 2023_04_03
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# Tutorial AIMS:
# 1. Chain together multiple lines of codes with pipes %>%
# 2. Use dplyr to its full potential
# 3. Automate advanced tasks like plotting without writing a loop
# Tutorial STEPS
# 1. An introduction to pipes
# 2. Discover more functions of dplyr
# --- summarise_all()
# --- case_when()
# 3. Rename and reorder factor levels or create categorical variables
# 4. Advanced piping
# 5. Challenge yourself! - separate file (01_PipelinesChallenge.R)

# clean the slate and start from the clear page
rm(list = ls())
dev.off()

#### Libraries ----
library(dplyr)     # for data manipulation
library(ggplot2)   # for making graphs
library(tidyr)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder
trees <- read.csv(file = "datasets/trees.csv", header = TRUE)

head(trees)  # make sure the data imported OK, familiarize yourself with the variables
dim(trees)
str(trees)

#### 1. Introduction to pipes ----
# The pipe operator %>% is a funny little thing that serves as a channel for 
# the output of a command to be passed to another function seamlessly, i.e., 
# without creating intermediary objects. It really makes your code flow, and 
# avoids repetition. Let’s first import the data, and then we’ll see what pipes 
# are all about.

# We want to know how many trees of each species are found in the dataset. 
# If you remember our first data manipulation tutorial, this is a task made for 
# the functions group_by() and summarise(). So we could do this:
  
# Count the number of trees for each species

trees.grouped <- group_by(trees, CommonName)    # create an internal grouping 
# structure, so that the next function acts on groups (here, species) separately.

trees.summary <- summarise(trees.grouped, count = length(CommonName))   # here we 
# use length to count the number of rows (trees) for each group (species). 
# We could have used any row name.

# Alternatively, dplyr has a tally function that does the counts for you!
trees.summary <- tally(trees.grouped)
trees.summary

# This works well, but notice how we had to create an extra data frame, 
# trees.grouped, before achieving our desired output of trees.summary

# This is where the pipe comes in to save the day. It takes the data frame created 
# on its left side, and passes it to the function on its right side. This saves 
# you the need for creating intermediary objects, and also avoids repeating the 
# object name in every function: the tidyverse functions “know” that the object 
# that is passed through the pipe is the data = argument of that function.

# Count the number of trees for each species, with a pipe!

trees.summary <- trees %>%                   # the data frame object that will be passed in the pipe
                 group_by(CommonName) %>%    # see how we don't need to name the object, just the grouping variable?
                 tally()                     # and we don't need anything at all here, it has been passed through the pipe!

trees.summary  # call the object to see the result

# Pipes only work on data frame objects, and functions outside the tidyverse 
# often require that you specify the data source with a full stop dot ..

# make a subset of a kind vs age group summarized
trees.subset <- trees %>%
  filter(CommonName %in% c('Common Ash', 'Rowan', 'Scots Pine')) %>%
  group_by(CommonName, AgeGroup) %>%
  tally()
trees.subset  # call the object to see the result

#### 2. More functions of dplyr ----
# An extension of the core dplyr functions is summarise_all(): you may have 
# guessed, it will run a summary function of your choice over ALL the columns. 
# Not meaningful here, but could be if all values were numeric, for instance.

#### a. summarise_all() ----
# - quickly generate a summary dataframe
summ.all <- summarise_all(trees, mean)
summ.all   # call the object to see the result
# As only two of the columns had numeric values over which a mean could be 
# calculated the other columns have missing values.

# let’s move on to a truly exciting function that not so many people know about.

#### b. case_when() ----
# - a favourite for re-classifying values or factors

# But first, it seems poor form to introduce this function without also 
# introducing the simpler function upon which it builds, ifelse(). 
# You give ifelse() a conditional statement which it will evaluate, and the 
# values it should return when this statement is true or false. Let’s do a very 
# simple example to begin with:
  
# make a vector
vector <- c(4, 13, 15, 6)      # create a vector to evaluate

# set a condition
ifelse(vector < 10, "A", "B")  # give the conditions: if inferior to 10, return A, if not, return B
# Congrats, you're a dancing queen! (Or king!)

# The super useful case_when() is a generalisation of ifelse() that lets you 
# assign more than two outcomes. All logical operators are available, and you 
# assign the new value with a tilde ~. For instance:
  
# make a second vector and enjoy case_when
vector2 <- c("What am I?", "A", "B", "C", "D")

case_when(vector2 == "What am I?" ~ "I am the walrus",
          vector2 %in% c("A", "B") ~ "goo",
          vector2 == "C" ~ "ga",
          vector2 == "D" ~ "joob")

# But enough singing, and let’s see how we can use those functions in real life
# to reclassify our variables.

#### 3. Changing factor levels or create categorical variables ----

# The use of mutate() together with case_when() is a great way to change the 
# names of factor levels, or create a new variable based on existing ones. 
# We see from the LatinName columns that there are many tree species belonging 
# to some genera, like birches (Betula), or willows (Salix), for example. We may
# want to create a Genus column using mutate() that will hold that information.

# We will do this using a character string search with the grepl function, which 
# looks for patterns in the data, and specify what to return for each genus. 
# Before we do that, we may want the full list of species occuring in the data!
  
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

# We have searched through the LatinNamecolumn for each genus name, and specified 
# a value to put in the new Genus column for each case. It’s a lot of typing, 
# but still quicker than specifying the genus individually for related trees 
# (e.g. Acer pseudoplatanus, Acer platanoides, Acer spp.).

# BONUS FUNCTION! 
# In our specific case, we could have achieved the same result much quicker. 
# The genus is always the first word of the LatinName column, and always separated 
# from the next word by a space. We could use the separate() function from 
# the tidyr package to split the column into several new columns filled with the 
# words making up the species names, and keep only the first one.

#library(tidyr)
trees.genus.2 <- trees %>%
  tidyr::separate(LatinName, c("Genus", "Species"), sep = " ", remove = FALSE) %>%  
  dplyr::select(-Species)

unique(trees.genus.2$Genus)  # Shows all the Genus names =Genus

# we're creating two new columns in a vector (genus name and species name), 
# "sep" refers to the separator, here space between the words, and remove = FALSE 
# means that we want to keep the original column LatinName in the data frame

# Mind blowing! Of course, sometimes you have to be typing more, so here is 
# another example of how we can reclassify a factor. The Height factor has 5 levels
# representing brackets of tree heights, but let’s say three categories would be 
# enough for our purposes. We create a new height category variable Height.cat:
  
trees.genus <- trees.genus %>%   # overwriting our data frame
  mutate(Height.cat =   # creating our new column
           case_when(Height %in% c("Up to 5 meters", "5 to 10 meters") ~ "Short",
                     Height %in% c("10 to 15 meters", "15 to 20 meters") ~ "Medium",
                     Height == "20 to 25 meters" ~ "Tall")
  )

unique(trees.genus$Height)      # get the original vector
unique(trees.genus$Height.cat)  # see the renamed vector
str(trees.genus$Height.cat)     # check the type of a new vector - CHR


#### Reordering factors levels

# We’ve seen how we can change the names of a factor’s levels, but what if you 
# want to change the order in which they display? R will always show them in 
# alphabetical order, which is not very handy if you want them to appear in a 
# more logical order.

# For instance, if we plot the number of trees in each of our new height 
# categories, we may want the bars to read, from left to right: ‘Short’, ‘Medium’, 
# ‘Tall’. However, by default, R will order them ‘Medium’, ‘Short’, ‘Tall’.

# To fix this, you can specify the order explicitly, and even add labels if you 
# want to change the names of the factor levels. Here, we put them in all capitals 
# to illustrate.

## Reordering a factor's levels

# check the type of data
str(trees.genus$Height.cat)     # check the type of a new vector - CHR

# factorize it
trees.genus$Height.cat <- as.factor(trees.genus$Height.cat) # gotta be factor!

levels(trees.genus$Height.cat)  # shows the factor levels in their default order

trees.genus$Height.cat <- factor(trees.genus$Height.cat,
                                 levels = c('Short', 'Medium', 'Tall'),   # whichever order you choose will be reflected in plots etc
                                 labels = c('SHORT', 'MEDIUM', 'TALL')    # Make sure you match the new names to the original levels!
)

levels(trees.genus$Height.cat)  # a new order and new names for the levels

# Are you now itching to make graphs too? We’ve kept to base R plotting in our 
# intro tutorials, but we are big fans of ggplot2 and that’s what we’ll be using
# in the next section while we learn to make graphs as outputs of a pipe chain. 
# If you haven’t used ggplot2 before, don’t worry, we won’t go far with it today.
# We have two tutorials dedicated to making pretty and informative plots with it. 
# Install and load the package if you need to:
  
# library(ggplot2)
# And let’s build up a plot-producing factory chain!

#### 4. Advanced piping ----
# Earlier in the tutorial, we used pipes to gradually transform our dataframes 
# by adding new columns or transforming the variables they contain. But sometimes 
# you may want to use the really neat grouping functionalities of dplyr with 
# non-native dplyr functions, for instance to run series of models or produce plots. 
# It can be tricky, but it’s sometimes easier to write than a loop. 
# (You can learn to write loops here.)

# First, we’ll subset our dataset to just a few tree genera to keep things light. 
# Pick your favourite five, or use those we have defined here! Then we’ll map 
# them to see how they are distributed.

# Subset data frame to fewer genera
trees.five <- trees.genus %>%
  filter(Genus %in% c("Acer", "Alnus", "Salix", "Larix", "Pinus"))

unique(trees.five$Genus)  # check the filtered names

# Map all the trees
(map.all <- ggplot(trees.five) +
    geom_point(aes(x = Easting, y = Northing, size = Height.cat, colour = Genus), alpha = 0.5) +
    theme_bw() +
    theme(panel.grid = element_blank(),
          axis.text = element_text(size = 12),
          legend.text = element_text(size = 12))
)

# Now, let’s say we want to save a separate map for each genus (so 5 maps in total). 

# You could filter the data frame five times for each individual genus, and copy 
# and paste the plotting code five times too, but imagine we kept all 17 genera! 
# This is where pipes and dplyr come to the rescue again. (If you’re savvy with 
# ggplot2, you’ll know that facetting is often a better option, but sometimes 
# you do want to save things as separate files.) The do() function allows us to 
# use pretty much any R function within a pipe chain, provided that we supply the 
# data as data = . where the function requires it.

# Plotting a map for each genus
tree.plots <-  
  trees.five  %>%      # the data frame
  group_by(Genus) %>%  # grouping by genus
  do(plots =           # the plotting call within the do function
       ggplot(data = .) +
       geom_point(aes(x = Easting, y = Northing, size = Height.cat), alpha = 0.5) +
       labs(title = paste("Map of", .$Genus, "at Craigmillar Castle", sep = " ")) +
       theme_bw() +
       theme(panel.grid = element_blank(),
             axis.text = element_text(size = 14),
             legend.text = element_text(size = 12),
             plot.title = element_text(hjust = 0.5),
             legend.position = "bottom")               # option of positioning
  )

# You can view the graphs before saving them
tree.plots$plots  # to view them use arrows in the Plots window

# get the right directory for plots to be saved at
getwd()
setwd("./02_Wiz_of_Data_Viz")


# Saving the plots to file
tree.plots %>%              # the saving call within the do function
  do(.,
     ggsave(.$plots, 
            filename = paste(getwd(),
                             "/", "map-", .$Genus, ".png", sep = ""), 
            device = "png", height = 12, width = 16, units = "cm"))

# get back to originally set working directory
setwd("../")  # moves you back - one step up
getwd()       # check if moved up correctly  

# The do() function allows to use a lot of external functions within dplyr pipe 
# chains. However, it is sometimes tricky to use and is becoming deprecated. 

#### Sticking things together with paste()

# Did you notice how we used the paste() function to define the filename= 
# argument of the last piece of code? (We did the same to define the titles t
# hat appear on the graphs.) It’s a useful function that lets you combine text
# strings as well as outputs from functions or object names in the environment. 
# Let’s take apart that last piece of code here:
  
# paste command
paste(getwd(), '/', 'map-', .$Genus, '.png', sep = '')

# --- getwd(): 
# You are familiar with this call: try it in the console now! It writes the path 
# to your working directory, i.e. the root folder where we want to save the plots.
# --- ’/’: we want to add a slash after the directory folder and before writing 
# the name of the plot
# --- ‘map-‘: a custom text bit that will be shared by all the plots. 
# We’re drawing maps after all!
# --- ’.$Genus’: accesses the Genus name of the tree.plots object, so each plot 
# will bear a different name according to the tree genus.
# --- ‘.png’: the file extension; we could also have chosen a pdf, jpg, etc.
# --- ‘sep = ‘’’: we want all the previous bits to be pasted together with 
# nothing separating them

# So, in the end, the whole string could read something like: 
# ‘C:/Coding_Club/map-Acer.png’.

#### 5. Challenge yourself! ----
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











