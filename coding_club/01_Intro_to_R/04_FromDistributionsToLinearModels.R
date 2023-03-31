#### FROM DISTRIBUTIONS TO LINEAR MODELS ----
# GETTING COMFORTABLE WITH THE BASICS OF STATISTICS MODELLING

#### Tutorial Aims & Steps:
# 1. Get familiar with different data distributions
# 2. Choosing your model structure
# 3. Practice linear models (and ANOVAs)
# --- Write and run the models
# --- Understand the outputs
# --- Verify the assumptions
# 4. Practice generalized linear models
# 5. Challenge yourself!

#### 1. Data distribution types ----

### Get familiar with different data distributions
# Here is a brief summary of the data distributions you might encounter most often.

# -- Gaussian - Continuous data (normal distribution and homoscedasticity assumed)
# -- Poisson - Count abundance data (integer values, zero-inflated data, left-skewed data)
# -- Binomial - Binary variables (TRUE/FALSE, 0/1, presence/absence data)

# Continuous - Gaussian, Discrete - Poisson, Binary - Binomial

#### 2. Model structure selection ----

# Another important aspect of modelling to consider is how many terms, i.e. 
# explanatory variables, you want your model to include. It’s a good idea to 
# draft out your model structure before you even open your R session. Let your 
# hypotheses guide you! Think about what it is you want to examine and what the 
# potential confounding variables are, i.e. what else might influence your 
# response variable, aside from the explanatory variable you are most interested in?

# A simple model is usually preferred to a complex model, but if you have strong 
# reasons for including a term in your model, then it should be there (whether 
# it ends up having an effect or not). Once you have carefully selected the 
# variables whose effects you need to quantify or account for, you can move onto 
# running your models.

# DANGER!!!
# if your model has a lot of variables, you are also in danger of overfitting

# Another thing to think about is collinearity among your explanatory variables. 
# If two variables in your dataset are very correlated with each other, chances 
# are they will both explain similar amounts of variation in your response 
# variable - but the same variation, not different or complementary aspects of it!

#### 3. Linear models practice ----

# We will now explore a few different types of models. Create a new script and 
# add in your details. We will start by working with a sample dataset about apple 
# yield in relation to different factors. 
# The dataset is part of the agridat package.

#### 4. Generalized linear models practice ----

# 

#### 5. Challenge ----

# 