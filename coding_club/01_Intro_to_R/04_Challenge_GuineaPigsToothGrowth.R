# Guinea Pigs Tooth Growth Challenge

#### Intro ----
# Basic Data Manipulations - Tooth Growth
# https://ourcodingclub.github.io/tutorials/modelling/index.html
# 2023_04_02
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### The Challenge ----
# Using the ToothGrowth built-in dataset describing tooth growth in guinea pigs 
# under different vitamin C treatments, can you answer the following questions?
ToothGrowth <- datasets::ToothGrowth

# - 1. Are higher doses of vitamin C beneficial for tooth growth?
# - 2. Does the method of administration (orange juice, OJ, 
# or ascorbic acid, VC) influence the effect of the dose?
# - 3. What would be the predicted tooth length of a guinea pig given 1 mg of 
# vitamin C as ascorbic acid?

#### Data used ----
ToothGrowth <- datasets::ToothGrowth


#### Data Exploration ----
summary(ToothGrowth)
dim(ToothGrowth)
str(ToothGrowth)


#### THE SOLUTION ----

# First, we need to convert the dose variable into a categorical variable.
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# Now we can run a model (ANOVA) using two interacting terms:
tooth.m <- lm(len ~ dose*supp, data = ToothGrowth)
summary(tooth.m)

# The model is highly significant, and together, dose and method explain around 
# 77% of the variation in tooth growth. Not bad! And to answer our questions:

# - 1. Higher doses of vitamin C promote tooth growth, but
# - 2. the effect of dose on growth depends on the administration method.
# - 3. A guinea pig given 1 mg a day as ascorbic acid would have a predicted 
# tooth growth of:
# --- 13.23 (growth for dose 0.5, orange juice)

# --- 9.47 (extra growth for dose 1.0, orange juice)
# -- -5.25 (difference in growth linked to the ascorbic acid treatment for dose 0.5)
# -- -0.68 (difference in growth for the interaction between dose 1.0 and ascorbic acid treatment) = 16.77

# And you can visualize the differences with a box plot:
library(ggplot2)

ggplot(ToothGrowth, aes(x = dose, y = len))+
  geom_boxplot(aes(colour = supp)) +
  theme.clean()






