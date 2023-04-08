#### INTRO TO SPATIAL ANALYSIS IN R - Script

#### Intro ----
# WORKING WITH RASTERS AND REMOTE-SENSING DATA
# Satellite data available from https://scihub.copernicus.eu/
# https://ourcodingclub.github.io/tutorials/spatial/index.html
# 2023_04_05
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

# In this tutorial, we are going to explore spatial analysis in R using satellite 
# data of the Loch Tay area of Scotland. Satellite or remote-sensing data are 
# increasingly used to answer ecological questions such as what are the 
# characteristics of species’ habitats, can we predict the distribution of 
# species and the spatial variability in species richness, and can we detect 
# natural and man-made changes at scales ranging from a single valley to the entire world.

# Around Loch Tay, for instance, remote-sensing data could be used to map different 
# vegetation types, such as invasive species like rhododendron, and track changes 
# over time. Alternatively, satellite data can be used to estimate forest cover 
# for an area like Scotland and help policy makers set new targets and assess progress.

#### Tutorial Aims ----
# 1. Explore raster data
# 2. Visualize spectral bands
# 3. Manipulate rasters: NDVI and KMN classification

# clean the slate
rm(list = ls())
dev.off()

#### Libraries ----
# install.packages("sp")
# install.packages("rgdal")
# install.packages("raster")
# install.packages("viridis")
# install.packages("viridisLite")
# install.packages("rasterVis")

library(sp)           # central for spatial data analysis in R
library(rgdal)        # read or save spatial data files - used by raster behind the scene
library(raster)       # creation, reading, manipulation and saving of raster data  
library(ggplot2)
library(viridisLite)
library(rasterVis)     
library(viridis)      # aesthetically pleasing colour palette visible to people with colour blindness

# The sp package is central for spatial data analysis in R as it defines a set 
# of classes to represent spatial data. Another important package for spatial 
# analysis is the raster package.

# A raster is a grid of equal size cells, or pixels in satellite images, and it 
# is commonly used to represent spatially continuous data. The cells can have one 
# or more values, or even no values for the variable of interest. In the trimmed 
# multispectral image we will be using, each cell contains relfectance data for 
# 12 spectral bands.

# The raster package has functions that allow the creation, reading, manipulation 
# and saving of raster data. The package rgdal is used to read or save spatial data 
# files and the package raster uses it behind the scenes.

# The package viridis is an aesthetically pleasing colour palette visible to 
# people with colour blindness. We will use it to plot our results as well as ggplot.

# First, we will use the raster package to read the satellite image file and 
# inspect its properties.

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Load data
tay <- raster("datasets/taycrop.tif")

# Get properties of the Tay raster
tay

# In the output, we get details of the image such as the number of bands, 
# dimension (number of rows, columns, and cells), the extent given by the 
# coordinate references, and the coordinate reference system (CRS) which is here 
# the Universal Trans Mercator (UTM) with datum WGS84.

#### Data exploration ----
# We can create individual raster layers for each of the spectral bands in the 
# raster tay.

b1 <- raster("datasets/taycrop.tif", band=1)
b2 <- raster("datasets/taycrop.tif", band=2)
b3 <- raster("datasets/taycrop.tif", band=3)
b4 <- raster("datasets/taycrop.tif", band=4)
b5 <- raster("datasets/taycrop.tif", band=5)
b6 <- raster("datasets/taycrop.tif", band=6)
b7 <- raster("datasets/taycrop.tif", band=7)
b8 <- raster("datasets/taycrop.tif", band=8)
b9 <- raster("datasets/taycrop.tif", band=9)
b10 <- raster("datasets/taycrop.tif", band=10)
b11 <- raster("datasets/taycrop.tif", band=11)
b12 <- raster("datasets/taycrop.tif", band=12)

# We can now compare two bands to see if they have the same extent, number of 
# rows and column, projection, resolution and origin. As can be seen below, 
# bands 2 and 3 match.
compareRaster(b2, b3)  # =TRUE

# Checking the coordinate systems and extents of rasters is a very useful 
# skill - quite often when you have problems with working with multiple raster 
# objects, it’s because of differences in coordinate systems or extents.

# The bands can be plotted using the plot or image function. Note that the plot 
# function only plots 100,000 pixels but image strectches the view.

plot(b8)    # Error in plot.new() : figure margins too large

image(b8)   # Error in plot.new() : figure margins too large

plot(b8)    # Error in plot.new() : figure margins too large
zoom(b8)    # run this line, then click twice on your plot to define a box

# Alternatively, an extent can be cropped and plotted from the plot image using
# the same double click method described above and the code below. Zooming in a
# llows you to visualise spatial data for specific areas you might be interested in.

plot(tay)
e <- drawExtent()    # run this line, then click twice on your plot to define a box
cropped_tay <- crop(b7, e)
plot(cropped_tay)

#### 2. Visualise spectral bands ----
# The bands can be plotted with different colour palettes to improve 
# visualisation, such as viridis, and saved using the code below.

png('tayplot.png', width = 4, height = 4, units = "in", res = 300)                	# to save plot
image(b8, col= viridis_pal(option="D")(10), main="Sentinel 2 image of Loch Tay")
dev.off()         									# to save plot
# dev.off() is a function that "clears the slate" - it just means you are done using that specific plot
# if you don't dev.off(), that can create problems when you want to save another plot

# To view the plot without saving the image, you only need the second line:
  
image(b8, col= viridis_pal(option="D")(10), main="Sentinel 2 image of Loch Tay")

# A useful way to visualise the satellite data is to plot a red-green-blue plot 
# of a multi-layered object for a more realistic rendition. The layers or bands 
# represent different bandwidth in the visible electromagnetic spectrum 
# (corresponding to red, blue and green) and combined, create a naturalistic 
# colour rendition of the earth surface.

# First, we will create a raster stack, a multi-layered raster object, of the 
# red(b4), green(b3) and blue(b2) bands.


# this code specifies how we want to save the plot
png('RGB.png', width = 5, height = 4, units = "in", res = 300)
tayRGB <- stack(list(b4, b3, b2))              # creates raster stack
plotRGB(tayRGB, axes = TRUE, stretch = "lin", main = "Sentinel RGB colour composite")
dev.off()

# Another popular way to visualise remote sensing data is using a false colour 
# composite (FCC), where the red, green, and blue bands have been replaced in 
# order to accentuate vegetation.

# In a FCC, the red bands is replaced by the near infrared band (band 8 in 
# Sentinel 2), the green band by red and the blue band by green. This creates 
# an image where the vegetation stands out in red. Check (help(plotRGB)) for 
# more information and other arguments for the function.

#### Exercise: Create a FCC of the Loch Tay area using a raster stack. ----
# The package rasterVis provides a number of ways to enhance the visualisation 
# and analysis of raster data, as can be seen on the package’s website here. 
# The function levelplot allows level and contour plots to be made of raster 
# objects with elevation data, such as LIDAR and plot3D allows 3D mapping. 
# We do not have elevation data from Sentinel 2, but the package’s gplot function
# allows us to plot a uni or multivariate raster object using ggplot2 like syntax.

gplot(b8) +
  geom_raster(aes(x = x, y = y, fill = value)) +
  # value is the specific value (of reflectance) each pixel is associated with
  scale_fill_viridis_c() +
  coord_quickmap() +
  ggtitle("West of Loch tay, raster plot") +
  xlab("Longitude") +
  ylab("Latitude") +
  theme_classic() +   					    # removes default grey background
  theme(plot.title = element_text(hjust = 0.5),             # centers plot title
        text = element_text(size=20),		       	    # font size
        axis.text.x = element_text(angle = 90, hjust = 1))  # rotates x axis text

ggsave("02_Wiz_of_Data_Viz/ggtay.png", scale = 1.5, dpi = 300) 		# to save plot





















