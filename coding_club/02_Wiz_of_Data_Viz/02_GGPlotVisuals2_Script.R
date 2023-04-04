#### BDATA VISUALISATION 2 - Script

#### Intro ----
# CUSTOMISING YOUR FIGURES
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

# colourpicker can be used via install.packages("colourpicker")
library(colourpicker)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")