##### SET UP THE WORKING DIRECTORY and DOWNLOAD LIBRARIES
# get the current working directory
getwd()

# in case the working directory is different, set it manually to:
setwd("/home/t51/DataAnalytics/R-Playground")

# create folder for Coding Club activities - remove the hash below to execute
dir.create("/home/t51/DataAnalytics/R-Playground/coding_club")

# set the working directory to Coding Club folder
setwd("/home/t51/DataAnalytics/R-Playground/coding_club")

# check if everything worked well with directory set-up
getwd()

install.packages("tidyverse")
install.packages("dplyr")

library(tidyverse) # tidyverse includes dplyr
library(dplyr) # in case you still want to be specific at set-up
