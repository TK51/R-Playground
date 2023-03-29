#### Intro ----
# Basic Data Manipulations 
# https://ourcodingclub.github.io/tutorials/data-manip-intro/index.html
# 2023_03_29
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Load the elongation data
elongation <- read.csv("./datasets/EmpetrumElongation.csv", header = TRUE)   

# Check import and preview data
head(elongation)   # first few observations
str(elongation)    # types of variables
dim(elongation)    # data set dimensions
