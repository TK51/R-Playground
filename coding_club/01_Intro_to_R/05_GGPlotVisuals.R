#### BEAUTIFUL AND INFORMATIVE DATA VISUALISATION

#### Intro ----
# USING GGPLOT2 TO COMMUNICATE YOUR RESULTS
# https://ourcodingclub.github.io/tutorials/datavis/index.html
# 2023_04_02
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# 1. Get familiar with the ggplot2 syntax
# 2. Decide on the right type of plot
# 3. Practice making different plots with ggplot2
# --- Histograms
# --- Scatter plots
# --- Box plots
# --- Bar plots
# 4. Learn to arrange graphs in a panel and to save files
# 5. Challenge yourself!

#### 1. Good data visualization and ggplot2 syntax ----

#### What good graphs have in common.
# - 1.	Appropriate plot type for results
# - 2.	Plot is well organised
# - 3.	X and Y axes use correct units
# - 4.	X and Y axes easy to read
# - 5.	Clear informative legend
# - 6.	Plot is not cluttered
# - 7.	Clear and consistent colour scheme
# - 8.	Plot is the right dimensions
# - 9.	Measures of uncertainty where appropriate
# - 10.	Concise and informative caption

#### 2. Decide on the right type of plot ----
# A very key part of making any data visualization is making sure that it is 
# appropriate to your data type (e.g. discrete vs continuous), and fits your 
# purpose, i.e. what you are trying to communicate!

## - Distribution: histogram, density, boxplot
## - Comparison: boxplot, bar plot, dot plot
## - Relationship: scatter plot

### Understanding ggplot2’s jargon
# Perhaps the trickiest bit when starting out with ggplot2 is understanding what 
# type of elements are responsible for the contents (data) versus the container 
# (general look) of your plot. Let’s de-mystify some of the common words you 
# will encounter.

# --- geom: a geometric object which defines the type of graph you are making. 
# It reads your data in the aesthetics mapping to know which variables to use, 
# and creates the graph accordingly. Some common types are geom_point(), 
# geom_boxplot(), geom_histogram(), geom_col(), etc.

# --- aes: short for aesthetics. Usually placed within a geom_, this is where 
# you specify your data source and variables, AND the properties of the graph 
# which depend on those variables. For instance, if you want all data points to 
# be the same colour, you would define the colour = argument outside the aes() 
# function; if you want the data points to be coloured by a factor’s levels 
# (e.g. by site or species), you specify the colour = argument inside the aes().

# --- stat: a stat layer applies some statistical transformation to the 
# underlying data: for instance, stat_smooth(method = 'lm') displays a linear 
# regression line and confidence interval ribbon on top of a scatter plot 
# (defined with geom_point()).

# --- theme: a theme is made of a set of visual parameters that control the 
# background, borders, grid lines, axes, text size, legend position, etc. You 
# can use pre-defined themes, create your own, or use a theme and overwrite only 
# the elements you don’t like. Examples of elements within themes are axis.text, 
# panel.grid, legend.title, and so on. You define their properties with 
# elements_...() functions: element_blank() would return something empty 
# (ideal for removing background colour), while 
# element_text(size = ..., face = ..., angle = ...) lets you control all kinds 
# of text properties.

# Also useful to remember is that layers are added on top of each other as 
# you progress into the code, which means that elements written later may hide 
# or overwrite previous elements.

# colourpicker can be used via install.packages("colourpicker")

#### 3. Making different plots with ggplot2 ----
#### 3a. Histograms ---- 
# to visualize data distribution
#### 3b. Scatter plot ----
# to examine population change over time
#### 3c. Boxplot ----
# to examine whether vulture abundance differs between Croatia and Italy
#### 3d. Barplot ----
# to compare species richness of a few European countries
#### 4. Using facets and creating panels ----
