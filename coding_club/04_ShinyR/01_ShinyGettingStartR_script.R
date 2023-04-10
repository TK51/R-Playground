#### GETTING STARTED WITH SHINY - Script

#### Intro ----
# CREATING INTERACTIVE WEB APPS USING THE R LANGUAGE
# https://ourcodingclub.github.io/tutorials/shiny/index.html
# 2023_04_10
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# Tutorial aims:
# 1. Downloading Shiny
# 2. Getting familiar with the Shiny app file structure
# 3. Getting familiar with the Shiny app.R layout
# 4. Creating a Shiny app
# 5. Exporting a finished app
# 6. Challenge yourself to write an app

# clean the slate and start from the clear page
rm(list = ls())
dev.off()

#### 1. Downloading Shiny and tutorial resources ----
# To get Shiny in RStudio, the first thing you need is the shiny package, by 
# running the code below in RStudio:
  
install.packages("shiny")
install.packages("rsconnect")  # For publishing apps online
install.packages("agridat")    # For the dataset in today's tutorial

# 2. The Shiny app file structure ----
# Next, select File/ New File/ Shiny Web App…, give the application a descriptive
# name (no spaces) and change the application type to “Single File (app.R)”, save 
# the app in an appropriate directory and click Create.

# RStudio generates a template R script called app.R. Delete all the code in the 
# template so you have a blank script.

# Notice that the name you gave to your app was assigned to the directory, not the 
#app script file. For your app to work, the file must remain named app.R!
  
# It is possible to create a Shiny app with two files called ui.R and server.R, 
# but the same can be accomplished by using one file. In the past, Shiny apps had 
# to be created using two files, but the Shiny package has since been updated to 
# allow the single file app structure, making things much tidier. You will see 
# some tutorials on the internet using the old two file structure, but these can 
#be easily translated to the one file structure. This tutorial will assume you 
# have the one file app structure.

# Now we can set up the rest of the folders for your app. Add a folder called 
# Data and a folder called www in your app directory. Data will hold any data 
# used by the app and www will hold any images and other web elements.

# To review, a Shiny application should have this specific folder structure to 
# work properly:

## Test app
## -- app.R
## -- Data
##   -- data.csv
## -- www
##   -- A.jpg

# 3. app.R layout ----
# Now that the folder structure is set up, head back to RStudio to start building 
# app.R. A basic app.R consists of these five parts:
  
# - A section at the top of the script loading any packages needed for the app to 
# run. shiny is required at the very least, but others like dplyr or ggplot2 
# could be added as they are needed:

# Packages ----
library(shiny)  # Required to run any Shiny app
library(ggplot2)  # For creating pretty plots
library(dplyr)  # For filtering and manipulating data
library(agridat)  # The package where the data comes from

# - A section loading any data needed by the app:

# Loading data ----
Barley <- as.data.frame(beaven.barley)

# - An object called ui, which contains information about the layout of the app as it appears in your web browser. fluidPage() defines a layout that will resize according to the size of the browser window. All the app code will be placed within the brackets.

# ui.R ----
ui <- fluidPage()

# - An object called server, which contains information about the computation of the app, creating plots, tables, maps etc. using information provided by the user. All the app code will be placed within the curly brackets.

# server.R ----
server <- function(input, output) {}

# - A command to run the app. This should be included at the very end of app.R. It tells shiny that the user interface comes from the object called ui and that the server information (data, plots, tables, etc.) comes from the object called server.

# Run the app ----
shinyApp(ui = ui, server = server)

# Delete any example code generated automatically when you created app.R and 
# create a basic Shiny app by copying the snippets of code above into your app.R. 
# Your script should now look like this:
  
_______________________________________________________________________
# Packages ----
library(shiny)  # Required to run any Shiny app
library(ggplot2)  # For creating pretty plots
library(dplyr)  # For filtering and manipulating data
library(agridat)  # The package where the data comes from

# Loading data ----
Barley <- as.data.frame(beaven.barley)

# ui.R ----
ui <- fluidPage()

# server.R ----
server <- function(input, output) {}

# Run the app ----
shinyApp(ui = ui, server = server
         
_______________________________________________________________________
#### Layout of a Shiny App ----
# Shiny apps are structured using panels, which are laid out in different 
# arrangements. Panels can contain text, widgets, plots, tables, maps, images, etc.

# Here (https://shiny.rstudio.com/articles/layout-guide.html) is a good set of 
# examples on how the panel layout can be changed. The most basic layout uses 
# fluidRow() and column() to manually create grids of a given size. fluidRow() 
# allows a lot of customisation, but is more fiddly. In this tutorial, we will 
# be using sidebarLayout(), which creates a large panel and a smaller inset side panel.




















