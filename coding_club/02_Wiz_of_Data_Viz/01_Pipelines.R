#### EFFICIENT DATA MANIPULATION - Theory

#### Intro ----
# USE PIPES TO STREAMLINE YOUR CODE
# https://ourcodingclub.github.io/tutorials/data-manip-efficient/index.html
# 2023_04_03
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----

# Tutorial AIMS:
# 1. Chain together multiple lines of codes with pipes %>%
# 2. Use dplyr to its full potential
# 3. Automate advanced tasks like plotting without writing a loop

# Tutorial STEPS
# 1. An introduction to pipes
# 2. Discover more functions of dplyr
# ---summarise_all()
# ---case_when()
# 3. Rename and reorder factor levels or create categorical variables
# 4. Advanced piping
# 5. Challenge yourself!

# 1. An introduction to pipes ----

# The pipe operator %>% is a funny little thing that serves as a channel for 
# the output of a command to be passed to another function seamlessly, i.e., 
# without creating intermediary objects. It really makes your code flow, and 
# avoids repetition. Let’s first import the data, and then we’ll see what pipes 
# are all about.

# You want to know how many trees of each species are found in the dataset. 
# If you remember our first data manipulation tutorial, this is a task made for 
# the functions group_by() and summarise().

# PIPELINE takes the data frame created on its left side, and passes it to the 
# function on its right side. This saves you the need for creating intermediary 
# objects, and also avoids repeating the object name in every function: 
# the tidyverse functions “know” that the object that is passed through the pipe 
# is the data = argument of that function.

# 2. Discover more functions of dplyr ----

# --- summarise_all()

# --- case_when()

# 3. Rename and reorder factor levels or create categorical variables ----

# 4. Advanced piping ----

# 5. Challenge yourself! ----
