# Dragons Challenge

#### Intro ----
# Basic Data Manipulations - Dragons Challenge
# https://ourcodingclub.github.io/tutorials/data-manip-intro/index.html
# 2023_03_30
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Load the elongation data
dragons <- read.csv("./datasets/dragons.csv", header = TRUE)   

#### Data exploration ----
# Check import and preview data
head(dragons)   # first few observations
str(dragons)    # types of variables
dim(dragons)    # data set dimensions
