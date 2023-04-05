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

library(sp)
library(rgdal)         
library(raster)          
library(ggplot2)
library(viridisLite)
library(rasterVis)     

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

#### Data exploration ----
# We will first explore our dataset using the str() function, which shows what 
# type each variable is. What is the dataset made of?

str(magic_veg)