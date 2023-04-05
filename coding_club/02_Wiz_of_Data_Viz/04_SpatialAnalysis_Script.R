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
library(dplyr)  # For data manipulation
library(ggplot2)  # For data visualisation

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