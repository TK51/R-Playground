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

# And if we want to make the columns to appear side by side rather than being 
# stacked, you add position = "dodge" to the geom’s arguments.

(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge"))

# Note how our figure only shows plot numbers 2, 4, and 6. If you want the axis 
# to display every plot number, 1 - 6, you can run the following code using 
# breaks = c(1,2,3,4,5,6) or using breaks = 1:6. We can also specify the limits 
# of the plot axes - running the code below, you’ll be able to see that the limit 
# of the y axis now extends to the value of 50! This helps us keep all our data 
# within the axis labels that we have, in terms of the visualisation!
  
(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") + 
    scale_x_continuous(breaks = c(1,2,3,4,5,6)) +  # or use breaks = 1:6
    scale_y_continuous(limits = c(0, 50)))

#### 1a. Add titles, subtitles, captions and axis labels ----
# Now it’s time for us to add more information to our graphs, for example, 
# the plot title, subtitle, caption and axis labels. This might not be so useful 
# in this case, but here’s some guidance just in case you do require this in your 
# own work.

(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") +
    scale_x_continuous(breaks = c(1,2,3,4,5,6)) + 
    scale_y_continuous(limits = c(0, 50)) +
    labs(title = "Species richness by plot", 
         subtitle = "In the magical lands",
         caption = "Data from the Ministry of Magic", 
         x = "\n Plot number", y = "Number of species \n"))     # \n adds space before x and after y axis text

#### Theme adding ----
# You can also add in theme() elements to your plot, which let you customise 
# even more aspects! We already introduced theme elements in our previous 
# tutorial. Here, we’re showing you how to change the font sizes of the axis 
# label (axis text), axis title and plot title. Other things you can play around 
# with are:
# -- italicise or bold the text with face = 'italic' or face = 'bold' respectively
# -- center the title using hjust = 0.5
# Note: if we wanted to specify different options for the x and y axis, we could 
# use axis.text.x or axis.title.x and axis.text.y or axis.title.y and specify 
# separate characteristics for each axis.

(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
   geom_histogram(stat = "identity", position = "dodge") +
   scale_x_continuous(breaks = c(1,2,3,4,5,6)) + 
   scale_y_continuous(limits = c(0, 50)) +
   labs(title = "Species richness by plot", 
        x = "\n Plot number", y = "Number of species \n") + 
   theme(axis.text = element_text(size = 12), 
         axis.title = element_text(size = 12, face = "italic"), 
         plot.title = element_text(size = 14, hjust = 0.5, face = "bold")))

#### 1b. Change the plot background ----
# All our graphs at the moment still have a grey background, and honestly, we’re 
# not a fan of it. It also has both major and minor grid lines for both 
# the y and x axes, which we might want to remove to have a clear plain white 
# background for the plot. Adding theme_bw() to our plot removes the grey 
# background and replaces it with a white one. There are various other themes 
# built into RStudio, but we personally think this is the cleanest one.

# To remove the grid lines, we add the code panel.grid = element_blank() within 
# the theme() command. Just like text.axis encompasses both text.axis.x 
# and text.axis.y, panel.grid encompasses several options: panel.grid.major, 
# which in turn governs panel.grid.major.x and panel.grid.major.y and the same 
# for panel.grid.minor!
  
(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") + 
    scale_x_continuous(breaks = c(1,2,3,4,5,6)) + 
    scale_y_continuous(limits = c(0, 50)) +
    labs(title = "Species richness by plot", 
         x = "\n Plot number", y = "Number of species \n") + 
    theme_bw() +
    theme(panel.grid = element_blank(), 
          axis.text = element_text(size = 12), 
          axis.title = element_text(size = 12), 
          plot.title = element_text(size = 14, hjust = 0.5, face = "bold")))

#### 1c. Fix the legend and customise the colours ----
# We will use the scale_...() functions to customise both the color code AND 
# the legend at once.

# The scale_fill_manual(values = c("your-colour-1", "your-colour-2", ...)) 
# function lets you decide on custom colour values for solid elements 
# (bars, boxplots, ribbons, etc.), and its counterpart scale_colour_manual() w
# orks exactly the same for line elements (points in a scatter plot, regression 
# lines, box or column outlines, etc.). You need to make sure you put in as many 
# colours as there are factor levels in your data.

# Also, notice how the name of our legend is now currently “land”: the title of 
# that column in our dataframe species_counts. It is not very informative and 
# not capitalized. We can change it to “Land of Magic,” by 
# specifying name = "Land of Magic" in our function scale_fill_manual(). 
# In some cases, we might not want to have a title for the legend at all, 
# which you can do by specifying in scale_fill_manual, name = NULL.

(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") + 
    scale_x_continuous(breaks = c(1,2,3,4,5,6)) + 
    scale_y_continuous(limits = c(0, 50)) +
    scale_fill_manual(values = c("#c979a0", "#79C9A2"),     # specifying the colours
                      name = "Land of Magic") +             # specifying title of legend
    labs(title = "Species richness by plot", 
         x = "\n Plot number", y = "Number of species \n") + 
    theme_bw() +
    theme(panel.grid = element_blank(), 
          axis.text = element_text(size = 12), 
          axis.title = element_text(size = 12), 
          plot.title = element_text(size = 14, hjust = 0.5, face = "bold"), 
          plot.margin = unit(c(0.5,0.5,0.5,0.5), units = , "cm"), 
          legend.title = element_text(face = "bold"),
          legend.position = "bottom", 
          legend.box.background = element_rect(color = "#555a57", size = 0.3)))

# Another thing that we might sometimes want to change is the actual label of the
# group (i.e. the factor levels). In the following example, our dataframe has 
# “Hogsmeade” and “Narnia” specified, which is lucky as they would reflect 
# correctly in the legend built by ggplot. However, if it they had simply been 
# listed as “group1” and “group2” in the original data file, we would want to 
# have more informative labels. We can do that by manipulating 
# labels = c("xxx", "xxx"). In the example below, we change the labels from the 
# default (taking from the dataframe) of “Hogsmeade” and “Narnia” to “HOGSMEADE” 
# and “NARNIA” just for demonstration purposes. 
# **Important:** Make sure you list the new label names in the same order as your 
# factors are listed in the dataset, otherwise you risk assigning the wrong group 
# to the values! Use levels(dataframe$factorname)to see the factors in order 
# (usually alphabetical).

(hist <- ggplot(species_counts, aes(x = plot, y = Species_number, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") + 
    scale_x_continuous(breaks = c(1,2,3,4,5,6)) + 
    scale_y_continuous(limits = c(0, 50)) +
    scale_fill_manual(values = c("#c979a0", "#79C9A2"),,           # specifying the colours
                      labels = c("HOGSMEADE", "NARNIA"),             # changing the site labels
                      name = "Land of Magic") +                      # defining legend title
    labs(title = "Species richness by plot", 
         x = "\n Plot number", y = "Number of species \n") + 
    theme_bw() +
    theme(panel.grid = element_blank(), 
          axis.text = element_text(size = 12), 
          axis.title = element_text(size = 12), 
          plot.title = element_text(size = 14, hjust = 0.5, face = "bold"), 
          plot.margin = unit(c(0.5,0.5,0.5,0.5), units = , "cm"), 
          legend.title = element_text(face = "bold"),
          legend.position = "bottom", 
          legend.box.background = element_rect(color = "#555a57", size = 0.3)))

# Let’s cover some more of the theme() elements we’ve used in the examples above:
  
# --legend.title allows you to change the font size of the legend, or its formatting 
# (e.g. bold).
# -- The legend.position can be defined with accepted positions such as "bottom", 
# but you can also do legend.position = c(0.1, 0.8), which would bring the legend 
# to the top left hand corner (corresponding to the x and y values on the graph). 
# This is a neat trick in some cases, where you have lots of blank space within 
# your plot itself and want to fine-tune the legend position.
# -- Finally, we’ve used legend.box.background = element_rect() to create a light
# grey rectangle that surrounds the legend. If you don’t want this, you can just 
# remove that line of code.

# To save a plot, we use the function ggsave() where you can specify the 
# dimensions and resolution of your plot. You could also change the file ending 
# with .png to .pdf to save your image as a PDF document. Note that this file 
# will be saved into your working directory. (If you’ve forgotten where that is, 
#3 you can find it by running the code getwd().)

# Note: If you want your file to be saved in a specific folder that is within your
# working directory (for example, into an “images” folder), you can change the 
# code from ggsave("magical-land-sp-richness.png") to 
# ggsave("images/magical-land-sp-richness.png"). 
# (Make sure you’ve created the folder first or you’ll run into an error!)

# save the graph
ggsave("./02_Wiz_of_Data_Viz/magical-sp-rich-hist.png", 
       width = 7, height = 5, dpi = 300)

#### 2. Create your own colour palette ----
# When you have several factor levels and need to come up with a pretty, clear,
# and contrasting colour scheme, it is always a good idea to look online for 
# inspiration. Some great websites we use are Colour Brewer or coolors. 
# Colour Brewer even allows you to specify colourblind-safe palettes, which you 
# definitely should want!
  
# A more advanced use of colour palettes is to create one linked to your factor 
# levels. This is great when you work on a project that will have multiple figures, 
# and you want the colour-coding to be consistent across the board. Linking 
# colours specifically to factor levels ensures that if a factor is dropped from 
# a data frame, the corresponding colour will be dropped from the resulting plot, 
# too, instead of being reassigned to the next available factor level.

# Here with only two magical lands, you could easily keep track of the colours, 
# but imagine if you had 10 different lands! Let’s create a fake dataframe of 
# values for more magical lands, and see the power of this approach.

# Create vectors with land names and species counts
land <- factor(c("Narnia", "Hogsmeade", "Westeros", "The Shire", "Mordor", "Forbidden Forest", "Oz"))
counts <- as.numeric(c(55, 48, 37, 62, 11, 39, 51))

# Create the new data frame from the vectors
more_magic <- data.frame(land, counts)

# We'll need as many colours as there are factor levels
length(levels(more_magic$land))    # that's 7 levels 

# CREATE THE COLOUR PALETTE
magic.palette <- c("#698B69", "#5D478B", "#5C5C5C", "#CD6090", "#EEC900", "#5F9EA0", "#6CA6CD")    # defining 7 colours
names(magic.palette) <- levels(more_magic$land)                                                    # linking factor names to the colours

# Bar plot with all the factors

(hist <- ggplot(more_magic, aes(x = land, y = counts, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") + 
    scale_y_continuous(limits = c(0, 65)) +
    scale_fill_manual(values = magic.palette,                        # using our palette here
                      name = "Land of Magic") +                
    labs(title = "Species richness in magical lands", 
         x = "", y = "Number of species \n") + 
    theme_bw() +
    theme(panel.grid = element_blank(), 
          axis.text = element_text(size = 12), 
          axis.text.x = element_text(angle = 45, hjust = 1), 
          axis.title = element_text(size = 12), 
          plot.title = element_text(size = 14, hjust = 0.5, face = "bold"), 
          plot.margin = unit(c(0.5,0.5,0.5,0.5), units = , "cm"), 
          legend.title = element_text(face = "bold"),
          legend.position = "bottom", 
          legend.box.background = element_rect(color = "grey", size = 0.3)))


# See how consistent the colour scheme is if you drop some factors (using 
# filter in the first line)

(hist <- ggplot(filter(more_magic, land %in% c("Hogsmeade", "Oz", "The Shire")), aes(x = land, y = counts, fill = land)) +
    geom_histogram(stat = "identity", position = "dodge") + 
    scale_y_continuous(limits = c(0, 65)) +
    scale_fill_manual(values = magic.palette,                       # using our palette ensures that colours with no corresponding factors are dropped
                      name = "Land of Magic") +                
    labs(title = "Species richness in magical lands", 
         x = "", y = "Number of species \n") + 
    theme_bw() +
    theme(panel.grid = element_blank(), 
          axis.text = element_text(size = 12), 
          axis.text.x = element_text(angle = 45, hjust = 1), 
          axis.title = element_text(size = 12), 
          plot.title = element_text(size = 14, hjust = 0.5, face = "bold"), 
          plot.margin = unit(c(0.5,0.5,0.5,0.5), units = , "cm"), 
          legend.title = element_text(face = "bold"),
          legend.position = "bottom", 
          legend.box.background = element_rect(color = "grey", size = 0.3)))















