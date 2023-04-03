#### BEAUTIFUL AND INFORMATIVE DATA VISUALISATION - Script

#### Intro ----
# USING GGPLOT2 TO COMMUNICATE YOUR RESULTS
# https://ourcodingclub.github.io/tutorials/datavis/index.html
# 2023_04_02
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# 1. Get familiar with the ggplot2 syntax
# 2. Decide on the right type of plot
# --- Distribution: histogram, density, boxplot
# --- Comparison: boxplot, bar plot, dot plot
# --- Relationship: scatter plot
# 3. Practice making different plots with ggplot2
# --- Histograms
# --- Scatter plots
# --- Box plots
# --- Bar plots
# 4. Learn to arrange graphs in a panel and to save files
# 5. Challenge yourself!

#### Libraries ----
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(gridExtra)

# colourpicker can be used via install.packages("colourpicker")
library(colourpicker)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from dataset folder
LPI <- read.csv("datasets/LPIdata_CC.csv")

#### Data exploration ----
dim(LPI)
head(LPI)
str(LPI)

# The data are in wide format - the different years are column names, when 
# really they should be rows in the same column. 
# We will reshape the data using the gather() function from the tidyr package

# Reshape data into long form
# By adding 9:53, we select columns 9 to 53, the ones for the 
# different years of monitoring
LPI2 <- gather(LPI, "year", "abundance", 9:53)
View(LPI2)

# There is an ‘X’ in front of all the years because when we imported the data, 
# all column names became characters. 
# (The X is R’s way of turning numbers into characters.) 
# Now that the years are rows, not columns, we need them to be proper numbers, 
# so we will transform them using parse_number() from the readr package

LPI2$year <- parse_number(LPI2$year)

# When manipulating data it's always good check if the variables have stayed 
# how we want them

str(LPI2)  # examine the structure of the data - year became numeric

# Abundance is also a character variable, when it should be numeric, let's fix that
# change the abundance from character to numeric
LPI2$abundance <- as.numeric(LPI2$abundance)

# the set is huge, let's focus on how the population of only one species has changed

# check the species available
unique(LPI2$Common.Name)

# set the filter to an exact specie "Griffon vulture / Eurasian griffon"
vulture <- filter(LPI2, Common.Name == "Griffon vulture / Eurasian griffon")
head(vulture)
dim(vulture)  # 1755 by 10 - including N/A values

# There are a lot of NAs in this dataframe, so we will get rid of the empty 
# rows using na.omit()

# get rid of empty rows using na.omit()
vulture <- na.omit(vulture)
head(vulture)
dim(vulture)  # 336 by 10 - excluding N/A values

#### Data visualization ----

# HISTOGRAMS ----

# With base R graphics
base_hist <- hist(vulture$abundance)

# The same with ggplot, we need to specify the type of graph using geom_histogram()

# With ggplot2: creating graph with no brackets
vulture_hist <- ggplot(vulture, aes(x = abundance))  +
  geom_histogram() 

# Calling the object to display it in the plot viewer
vulture_hist

# With brackets: you create and display the graph at the same time
(vulture_hist <- ggplot(vulture, aes(x = abundance))  +
    geom_histogram())

# For another way to check whether your data is normally distributed, you can 
# either create density plots using package ggpubr and command ggdensity(), 
# OR use functions qqnorm() and qqline()

# The default ggplot settings (right) are not ideal: there is lots of unnecessary 
# grey space behind the histogram, the axis labels are quite small, and the bars 
# blend with each other. Lets beautify the histogram a bit! 
# This is where the true power of ggplot2 shines.

(vulture_hist <- ggplot(vulture, aes(x = abundance)) +                
    geom_histogram(binwidth = 250, colour = "#8B5A00", fill = "#FAB941") +    # Changing the binwidth and colours
    geom_vline(aes(xintercept = mean(abundance)),                       # Adding a line for mean abundance
               colour = "red", linetype = "dashed", size=1) +           # Changing the look of the line
    theme_bw() +                                                        # Changing the theme to get rid of the grey background
    ylab("Count\n") +                                                   # Changing the text of the y axis label
    xlab("\nGriffon vulture abundance")  +                              # \n adds a blank line between axis and text
    theme(axis.text = element_text(size = 12),                          # Changing font size of axis labels and title
          axis.title.x = element_text(size = 14, face = "plain"),       # face="plain" is the default, you can change it to italic, bold, etc. 
          panel.grid = element_blank(),                                 # Removing the grey grid lines
          plot.margin = unit(c(1,1,1,1), units = , "cm")))              # Putting a 1 cm margin around the plot

# We can see from the histogram that the data are very skewed - a typical 
# distribution of count abundance data

# Hist DESCRIPTION ----
# Histogram of Griffon vulture abundance in populations included in the LPI 
# dataset. Red line shows mean abundance. Isn’t it a much better plot already?

# SCATTER PLOT ----
# to examine population change over time

# Let’s say we are interested in how the Griffon vulture populations have 
# changed between 1970 and 2017 in Croatia and in Italy.

# Filtering the data to get records only from Croatia and Italy using 
# the `filter()` function from the `dplyr` package
vultureITCR <- filter(vulture, Country.list %in% c("Croatia", "Italy"))

# Using default base graphics
plot(vultureITCR$year, vultureITCR$abundance, col = c("#1874CD", "#EEB422"))

# Using default ggplot2 graphics
(vulture_scatter <- ggplot(vultureITCR, aes(x = year, y = abundance, colour = Country.list)) +  # linking colour to a factor inside aes() ensures that the points' colour will vary according to the factor levels
    geom_point())

# like with the histogram, the graph above needs a bit more work.
(vulture_scatter <- ggplot(vultureITCR, aes (x = year, y = abundance, colour = Country.list)) +
    geom_point(size = 2) +                                               # Changing point size
    geom_smooth(method = "lm", aes(fill = Country.list)) +               # Adding linear model fit, colour-code by country
    theme_bw() +
    scale_fill_manual(values = c("#EE7600", "#00868B")) +                # Adding custom colours for solid geoms (ribbon)
    scale_colour_manual(values = c("#EE7600", "#00868B"),                # Adding custom colours for lines and points
                        labels = c("Croatia", "Italy")) +                # Adding labels for the legend
    ylab("Griffon vulture abundance\n") +                             
    xlab("\nYear")  +
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),     # making the years at a bit of an angle
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 14, face = "plain"),                        
          panel.grid = element_blank(),                                   # Removing the background grid lines               
          plot.margin = unit(c(1,1,1,1), units = , "cm"),                 # Adding a 1cm margin around the plot
          legend.text = element_text(size = 12, face = "italic"),         # Setting the font for the legend text
          legend.title = element_blank(),                                 # Removing the legend title
          legend.position = c(0.9, 0.9)))                                 # Setting legend position - 0 is left/bottom, 1 is top/right

# Scat DESCRIPTION ----
# Population trends of Griffon vulture in Croatia and Italy. Data points 
# represent raw data with a linear model fit and 95% confidence intervals. 
# Abundance is measured in number of breeding individuals.

# Good to know
# If your axis labels need to contain special characters or superscript, you can 
# get ggplot2 to plot that, too. It might require some googling regarding your 
# specific case, but for example, this code 
# ylabs(expression(paste('Grain yield',' ','(ton.', ha^-1, ')', sep=''))) 
# will create a y axis with a label reading Grain yield (ton. ha-1).

# To create additional space between an axis title and the axis itself, use \n 
# when writing your title, and it will act as a line break.

# BOXPLOT ---- 
# to examine whether vulture abundance differs between Croatia and Italy

# Box plots are very informative as they show the median and spread of your data, 
# and allow you to quickly compare values among groups. If some boxes don’t 
# overlap with one another, you probably have significant differences, and it’s 
# worth to investigate further with statistical tests.

(vulture_boxplot <- ggplot(vultureITCR, aes(Country.list, abundance)) + geom_boxplot())

# Beautifying
(vulture_boxplot <- ggplot(vultureITCR, aes(Country.list, abundance)) + 
    geom_boxplot(aes(fill = Country.list)) +
    theme_bw() +
    scale_fill_manual(values = c("#EE7600", "#00868B")) +               # Adding custom colours
    scale_colour_manual(values = c("#EE7600", "#00868B")) +             # Adding custom colours
    ylab("Griffon vulture abundance\n") +                             
    xlab("\nCountry")  +
    theme(axis.text = element_text(size = 12),
          axis.title = element_text(size = 14, face = "plain"),                     
          panel.grid = element_blank(),                                 # Removing the background grid lines               
          plot.margin = unit(c(1,1,1,1), units = , "cm"),               # Adding a margin
          legend.position = "none"))                                    # Removing legend - not needed with only 2 factors

# Boxplot DESCRIPTION ----
# Griffon vulture abundance in Croatia and Italy.

# BARPLOT ----
# to compare species richness of a few European countries

# We are now going to calculate how many species are found in the LPI dataset 
# for some European countries, and plot the species richness.

# Calculating species richness using pipes %>% from the dplyr package
richness <- LPI2 %>% filter (Country.list %in% c("United Kingdom", "Spain", "France", "Netherlands", "Italy")) %>%
  group_by(Country.list) %>%
  mutate(richness = (length(unique(Common.Name)))) # create new column based on how many unique common names (or species) there are in each country 

# Plotting the species richness
(richness_barplot <- ggplot(richness, aes(x = Country.list, y = richness)) +
    geom_bar(position = position_dodge(), stat = "identity", colour = "black", fill = "#00868B") +
    theme_bw() +
    ylab("Species richness\n") +                             
    xlab("Country")  +
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),  # Angled labels, so text doesn't overlap
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 14, face = "plain"),                      
          panel.grid = element_blank(),                                          
          plot.margin = unit(c(1,1,1,1), units = , "cm")))

# Barplot DESCRIPTION ----
# Species richness in five European countries (based on LPI data).

# FACETS ----
# Sometimes, displaying all the data on one graph makes it too cluttered. 
# If we wanted to examine the population change of vultures across all the 
# countries, rather than Italy and Croatia, we would have 10 populations on the 
# same graph:

# Plot the population change for all countries
(vulture_scatter_all <- ggplot(vulture, aes (x = year, y = abundance, colour = Country.list)) +
   geom_point(size = 2) +                                               # Changing point size
   geom_smooth(method = "lm", aes(fill = Country.list)) +               # Adding linear model fit, colour-code by country
   theme_bw() +
   ylab("Griffon vulture abundance\n") +                             
   xlab("\nYear")  +
   theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),     # making the years at a bit of an angle
         axis.text.y = element_text(size = 12),
         axis.title = element_text(size = 14, face = "plain"),                        
         panel.grid = element_blank(),                                   # Removing the background grid lines               
         plot.margin = unit(c(1,1,1,1), units = , "cm"),                 # Adding a 1cm margin around the plot
         legend.text = element_text(size = 12, face = "italic"),         # Setting the font for the legend text
         legend.title = element_blank(),                                 # Removing the legend title
         legend.position = "right"))   

# That’s cluttered! 
# Can you really figure out what populations are doing? 
# By adding a facetting layer, we can split the data in multiple facets 
# representing the different countries. This is done using facet_wrap().

# Plot the population change for countries individually
(vulture_scatter_facets <- ggplot(vulture, aes (x = year, y = abundance, colour = Country.list)) +
    geom_point(size = 2) +                                               # Changing point size
    geom_smooth(method = "lm", aes(fill = Country.list)) +               # Adding linear model fit, colour-code by country
    facet_wrap(~ Country.list, scales = "free_y") +                      # THIS LINE CREATES THE FACETTING
    theme_bw() +
    ylab("Griffon vulture abundance\n") +                             
    xlab("\nYear")  +
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),     # making the years at a bit of an angle
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 14, face = "plain"),                        
          panel.grid = element_blank(),                                   # Removing the background grid lines               
          plot.margin = unit(c(1,1,1,1), units = , "cm"),                 # Adding a 1cm margin around the plot
          legend.text = element_text(size = 12, face = "italic"),         # Setting the font for the legend text
          legend.title = element_blank(),                                 # Removing the legend title
          legend.position = "right"))   

dev.off() # to clean up the plot section

# Some useful arguments to include in facet_wrap()are nrow = or ncol = , 
# specifying the number of rows or columns, respectively. You can also see that
# we used scales = "free_y", to allow different y axis values because of the 
# wide range of abundance values in the data. You can use “fixed” when you want 
# to constrain all axis values.

# Facetted DESCRIPTION ----
# Population change of Griffon vulture across the world, from the LPI dataset.

# Note: 
# some of these population trends do weird things, possibly because there are 
# many sub-populations being monitored within a country (e.g. Italy), so in 
# practice we probably would not fit a single regression line per country.

# PANELS ----
# And finally, sometimes you want to arrange multiple figures together to create 
# a panel. We will do this using grid.arrange() from the package gridExtra.

grid.arrange(vulture_hist, vulture_scatter, vulture_boxplot, ncol = 1)

# This doesn't look right - the graphs are too stretched, the legend and text 
# are all messed up, the white margins are too big

# Fixing the problems - adding ylab() again overrides the previous settings
(panel <- grid.arrange(
  vulture_hist + ggtitle("(a)") + ylab("Count") + xlab("Abundance") +   # adding labels to the different plots
    theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), units = , "cm")),
  
  vulture_boxplot + ggtitle("(b)") + ylab("Abundance") + xlab("Country") +
    theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), units = , "cm")),
  
  vulture_scatter + ggtitle("(c)") + ylab("Abundance") + xlab("Year") +
    theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), units = , "cm")) +
    theme(legend.text = element_text(size = 12, face = "italic"),     
          legend.title = element_blank(),                                   
          legend.position = c(0.85, 0.85)), # changing the legend position so that it fits within the panel
  
  ncol = 1)) # ncol determines how many columns you have

# Dimension changes ----
# If you want to change the width or height of any of your pictures, you can add 
# either ` widths = c(1, 1, 1) or heights = c(2, 1, 1)` for example, to the end 
# of your grid arrange command. In these examples, this would create three plots 
# of equal width, and the first plot would be twice as tall as the other two, 
#respectively. This is helpful when you have different sized figures or if you 
# want to highlight the most important figure in your panel.

# To get around the too stretched/too squished panel problems, we will save the 
# file and give it exact dimensions using ggsave from the ggplot2 package. The 
# default width and height are measured in inches. If you want to swap to pixels 
# or centimeters, you can add units = "px" or units = "cm" inside the ggsave() 
# brackets, e.g. 
# ggsave(object, filename = "mymap.png", width = 1000, height = 1000, units = "px". 
# The file will be saved to wherever your working directory is which you can 
# check by running getwd() in the console.

getwd()
ggsave(panel, file = "vulture_panel2.png", width = 6, height = 12) 

# Panel DESCRIPTION ----
# Examining Griffon vulture populations from the LPI dataset. (a) shows 
# histogram of abundance data distribution, (b) shows a boxplot comparison of 
# abundance in Croatia and Italy, and (c) shows population trends between 1970 
# and 2014 in Croatia and Italy.



