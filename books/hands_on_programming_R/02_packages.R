#### Hands-On Programming with R by Garrett Grolemund - Script
# 3. Packages and Help Pages
# https://rstudio-education.github.io/hopr/packages.html
# 2023_04_12
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Packages and Help Pages ----

# install packages
install.packages("ggplo2")

# initiate packages
library(ggplot2)

# check the qplot() function
qplot

# make an input into a qplot() and visualize it
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x  # -1.0 -0.8 -0.6 -0.4 -0.2  0.0  0.2  0.4  0.6  0.8  1.0

y <- x ^ 3
y  # -1.000 -0.512 -0.216 -0.064 -0.008  0.000  0.008 0.064  0.216  0.512  1.000

# visualize the vectors made
qplot(x, y)

# make a histogram - it takes only one vector (x or y)
x <- c(1, 2, 2, 2, 3, 3)
qplot(x, binwidth = 1)

# make another histogram
x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2, binwidth = 1)

# practice another histogram
x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
qplot(x3, binwidth = 1)

# replicate provides an easy way to repeat an R command many times. 
# To use it, first give replicate the number of times you wish to repeat 
# an R command, and then give it the command you wish to repeat. 
# replicate will run the command multiple times and store the results as a vector

replicate(3, 1 + 1)  # 2 2 2

replicate(10, roll2())  # shows the combinations
replicate(10, roll()) # 8 11  7  8 11  7  7  6  8  3

# Let’s simulate 10,000 dice rolls and plot the results using replicate & qplot
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

# get the help on sample and find out probability argument
?sample

# Rewrite the roll function below to roll a pair of weighted dice:
  roll <- function() {
    die <- 1:6
    dice <- sample(die, size = 2, replace = TRUE)
    sum(dice)
  }
roll()

# Solution. To weight your dice, you need to add a prob argument with a vector 
# of weights to sample, like this
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE, 
                 prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}
roll()

# check the change with visualization
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)  # see the sum moving to the right;)

# The dice are now clearly biased towards high numbers, since high sums occur 
# much more often than low sums












