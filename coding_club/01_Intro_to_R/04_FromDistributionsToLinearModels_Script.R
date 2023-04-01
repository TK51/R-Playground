#### Intro ----
# Basic Data Manipulations 
# https://ourcodingclub.github.io/tutorials/modelling/index.html
# 2023_03_31
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# Here, a few different types of models are to be explored. 
# The work starts with a sample dataset about apple yield in relation to 
# different factors. The dataset is part of the agridat package.

#### Libraries ----
install.packages("agridat")
library(agridat)
library(ggplot2)
library(dplyr)

#### Working directory ----
# Set working directory
getwd()
setwd("./coding_club")

#### Data source ----
# Loading the dataset from agridat
apples <- agridat::archbold.apple
dim(apples)
head(apples)
str(apples)
summary(apples)

#### Data exploration ----
# Check the data by visualizing it

# first, define a ggplot2 theme for creation of consistent graph formatting
theme.clean <- function() {
  theme_bw()+
    theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 1, hjust = 1),
          axis.text.y = element_text(size = 12),
          axis.title.x = element_text(size = 14, face = "plain"),             
          axis.title.y = element_text(size = 14, face = "plain"),             
          panel.grid.major.x = element_blank(),                                          
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_blank(),  
          plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), units = , "cm"),
          plot.title = element_text(size = 20, vjust = 1, hjust = 0.5),
          legend.text = element_text(size = 12, face = "italic"),          
          legend.position = "right")
}

# make a boxplot to examine the data
# idea - see the the influence of distance between trees to the yield cropped

apples$spacing2 <- as.factor(apples$spacing) # set spacing int as factor
# This turns the previously numeric spacing variable into a 3-level categorical 
# variable, with 6, 10 and 14 being the levels.

(apples.p <- ggplot(apples, aes(spacing2, yield)) +
    geom_boxplot(fill = "#CD3333", alpha = 0.8, colour = "#8B2323") +
    theme.clean() +  
    theme(axis.text.x = element_text(size = 12, angle = 0)) +
    labs(x = "Spacing (m)", y = "Yield (kg)"))

apples.p  # call the object to visualize the plot

# From the boxplot, we can see that yield is pretty similar across the different 
# spacing distances. Even though there is a trend towards higher yield at higher 
# spacing, the range in the data across the categories almost completely overlap. 
# From looking at this boxplot alone, one might think our hypothesis of higher 
# yield at higher spacing is not supported. 

# Let’s run a model to explicitly test this.
apples.m <- lm(yield ~ spacing2, data = apples)
summary(apples.m)

# Check out the summary output of our model:
#Turns out that yield does significantly differ between the three spacing 
# categories, so we can reject the null hypothesis of no effect of spacing on 
# apple yield. It looks like apple yield is indeed higher when the distance 
# between trees is higher, which is in line with our original ecological thoughts: 
# the further away trees are from one another, the less they are limiting each 
# other’s growth.

### SUMMARY EXPLANATION:
# -- Estimate
# A very important thing to understand is that the estimates for the other 
# categories are presented relative to the reference level. So, for the 
# 10-m spacing category, the estimated value from the model is not 35.9, 
# but 35.9 + 120.6 = 156.5. A look at our boxplot will make this easy to verify.

# -- Multiple R-squared value & Adjusted R-squared value
# These values refer to how much of the variation in the yield variable is 
# explained by our predictor spacing2. The values go from 0 to 1, with 1 meaning 
# that our model variables explain 100% of the variation in the examined variable. 
# - R-squared values tend to increase as you add more terms to your model, 
# but you also need to be wary of overfitting. 
# - Adjusted R-squared value takes into account how many terms your model has 
# and how many data points are available in the response variable.

### MODEL OUTCOME:
# So now, can we say this is a good model? It certainly tells us that spacing 
# has a significant effect on yield, but maybe not a very important one compared 
# to other possible factors influencing yield, as spacing only explains 
# around 15% of the variation in yield. Imagine all the other things that could 
# have an impact on yield that we have not studied: fertilisation levels, 
# weather conditions, water availability, etc. So, no matter how excited you 
# might be of reporting significant effects of your variables, especially if 
# they confirm your hypotheses, always take the time to assess your model with 
# a critical eye!

# More practice: another model
sheep <- agridat::ilri.sheep   # load the data

library(dplyr)
sheep <- filter(sheep, ewegen == "R")   # there are confounding variables in this dataset that we don't want to take into account. We'll only consider lambs that come from mothers belonging to the breed "R".

head(sheep)  # overview of the data; we'll focus on weanwt (wean weight) and weanage

sheep.m1 <- lm(weanwt ~ weanage, data = sheep)   # run the model
summary(sheep.m1)                                # study the output

# MODEL EXPLANATION:

# In the apple model, our predictor spacing was a CATEGORICAL variable. Here, 
# our predictor weanage is a CONTINUOUS variable.

# Here, the intercept is the value of Y when X is 0. In many models this is not 
# of interest and sometimes doesn’t make a ton of sense, but in our case you 
# could potentially argue that it’s the weight of a newborn lamb. 

# hte weight prediction formula: lamb weight = 2.60 + 0.08(age).

# So far, so good? Let’s read one extra output where things get a little bit 
# more complex. Our model, with weanageas the sole predictor, currently only 
# explains about 20% of the variation in the weight at weaning. 

# What if the sex of the lamb also influences weight gain? 
# Let’s run a new model to test this:
sheep.m2 <- lm(weanwt ~ weanage*sex, data = sheep)
summary(sheep.m2)

# Let’s write the equations. For a female, which happens to be the reference 
# group in the model, it’s fairly simple:

### Female weight = 3.66 + 0.06(age) : 
# The weight at 100 days would be 3.66 + 0.06(100) = 9.66 kg.

# For a male, it’s a little more complicated as you need to add the differences 
# in intercept and slopes due to the sex level being male:
  
### Male weight = 3.66 + [-2.52] + 0.06(age) + [0.03(age)] : 
# The weight at 100 days would be 3.66 - 2.52 + (0.06+0.03)(100) = 10.14 kg.

# It always makes a lot more sense when you can visualize the relationship, too:
  
(sheep.p <- ggplot(sheep, aes(x = weanage, y = weanwt)) +
    geom_point(aes(colour = sex)) +                                # scatter plot, coloured by sex
    labs(x = "Age at weaning (days)", y = "Wean weight (kg)") +
    stat_smooth(method = "lm", aes(fill = sex, colour = sex)) +    # adding regression lines for each sex
    scale_colour_manual(values = c("#FFC125", "#36648B")) +
    scale_fill_manual(values = c("#FFC125", "#36648B")) +
    theme.clean() )

sheep.p  # call the object to get the visualization

### MODEL OUTCOME:
# Our model tells us that weight at weaning increases significantly with weaning 
# date, and there is only a marginal difference between the rate of males’ and 
# females’ weight gain. The plot shows all of this pretty clearly.




















