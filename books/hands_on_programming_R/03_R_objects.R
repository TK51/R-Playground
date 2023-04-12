#### Hands-On Programming with R by Garrett Grolemund - Script
# 5. R Objects
# https://rstudio-education.github.io/hopr/r-objects.html
# 2023_04_12
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### R Objects ----
#### 5.1 Atomic Vectors
# You can make an atomic vector by grouping some values of data together with c:
die <- c(1, 2, 3, 4, 5, 6)
die  # 1 2 3 4 5 6

is.vector(die)  
## TRUE

# vector can include a single value
five <- 5
five  
## 5

is.vector(five)  ##  TRUE

length(five)  
## 1
length(die)  
## 6

# 5.1.1 Doubles
die <- c(1, 2, 3, 4, 5, 6)
die  
## 1 2 3 4 5 6

typeof(die)  
## "double" or numerics

# 5.1.2 Integers
int <- c(-1L, 2L, 4L)
int
## -1  2  4

typeof(int)
## "integer"


