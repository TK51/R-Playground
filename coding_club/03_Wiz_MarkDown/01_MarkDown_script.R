#### EGETTING STARTED WITH R MARKDOWN - Script

#### Intro ----
# CREATING A NEAT AND REPRODUCIBLE RECORD OF YOUR CODE
# https://ourcodingclub.github.io/tutorials/rmarkdown/index.html
# the RMarkDown Book: https://bookdown.org/yihui/rmarkdown/
# 2023_04_08
# Taras Khamardiuk (https://www.kaggle.com/taraskhamardiuk)

#### Description ----
# Tutorial AIMS:
# 1. Understand what RMarkdown is and why you should use it
# 2. Learn how to construct an RMarkdown file
# 3. Export an RMarkdown file into many file formats
# Tutorial STEPS
# 1. What is RMarkdown
# 2. Download RMarkdown
# 3. Create an RMarkdown (.Rmd) file
# 4. YAML header material
# 5. Markdown syntax
# 6. Insert code from an R script into a .Rmd file
# 7. Create a .pdf file from your .Rmd file
# 8. R Notebooks (the future of reproducible code? Maybe?)

# clean the slate and start from the clear page
rm(list = ls())

#### Libraries ----
#install.packages("rmarkdown")          # - if you're missing one
library(rmarkdown)
library(dplyr)

#### Working directory ----
# Set working directory
getwd()
setwd("./03_Wiz_MarkDown")

#### 1. What is RMarkdown ----
# Markdown is a very simple ‘markup’ language which provides methods for 
# creating documents with headers, images, links etc. from plain text files, 
# while keeping the original plain text file easy to read. You can convert 
# Markdown documents to many other file types like .html or .pdf to display 
# the headers, images etc.

# 2. Download RMarkdown ----
#install.packages("rmarkdown")          # - if you're missing one

# 3. Create an RMarkdown (.Rmd) file ----
# To create a new RMarkdown file (.Rmd), select File -> New File -> R Markdown..._ 
# in RStudio, then choose the file type you want to create. For now we will 
# focus on a .html Document, which can be easily converted to other file types later.

# The newly created .Rmd file comes with basic instructions, but we want to 
# create our own RMarkdown script, so go ahead and delete everything in the 
# example file.

# Now open the RMarkdown_Tutorial.R practice script from the repository you 
# downloaded earlier in another tab in RStudio and use the instructions below to 
# help you convert this script into a coherent RMarkdown document, bit by bit.

# 4. YAML header material ----
# the Book is here: https://bookdown.org/yihui/rmarkdown/

# By default, RStudio opens a separate preview window to display the output of 
# your .Rmd file. If you want the output to be displayed in the Viewer window 
# in RStudio (the same window where you would see plotted 
# figures / packages / file paths), select “View in Pane” from the drop down 
# menu that appears when you click on the Knit button in the taskbar, or in the 
# Settings gear icon drop down menu next to the Knit button.

# A preview appears, and a .html file is also saved to the same folder where you 
# saved your .Rmd file.

# 5. Markdown syntax ----

# You can use regular markdown rules in your R Markdown document. Once you knit 
# your document, the output will display text formatted according to the 
# markdown simple rules.

# Formatting Text
# Here are a few common formatting commands:
  
#  *Italic*
#  Italic

# **Bold**
#  Bold

# This is `code` in text
# This is code in text

# Header 1
# Header 1

## Header 2
# Header 2

# Note that when a # symbol is placed inside a code chunk it acts as a normal R 
# comment, but when placed in text it controls the header size.

# * Unordered list item
# Unordered list item

# 1. Ordered list item
# Ordered list item

# [Link](https://www.google.com)
# Link

# $A = \pi \times r^{2}$
#  Rendered equation example

# The $ symbols tells R markdown to use LaTeX equation syntax.

# To practice this, try writing some formatted text in your .Rmd document and 
# producing a .html page using the “Knit” button.

# 6. Insert code from an R script into a .Rmd file ----

# Below the YAML header is the space where you will write your code, 
# accompanying explanation and any outputs. Code that is included in your .Rmd 
# document should be enclosed by three backwards apostrophes ``` (grave accents!). 
# These are known as code chunks and look like this:
  
```{r}
norm <- rnorm(100, mean = 0, sd = 1)
```
# Inside the curly brackets is a space where you can assign rules for that code 
# chunk. The code chunk above says that the code is R code. We’ll get onto some 
# other curly brace rules later.

# Have a go at grabbing some code from the example R script and inserting it into 
# a code chunk in your .Rmd document.

# You can run an individual chunk of code at any time by clicking on the small 
# green arrow

#### More on Code Chunks
# It’s important to remember when you are creating an RMarkdown file that if you 
# want to run code that refers to an object, for example:
  
```{r}
print(dataframe)
```
# you must include instructions showing what dataframe is, just like in a normal
#R script. For example:
  
```{r}
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)
```
# Or if you are loading a dataframe from a .csv file, you must include the code 
# in the .Rmd:
  
```{r}
dataframe <- read.csv("~/Desktop/Code/dataframe.csv")
```
# Similarly, if you are using any packages in your analysis, you will have to 
# load them in the .Rmd file using library() as in a normal R script.

```{r}
library(dplyr)
```
#### Hiding code chunks ----
# If you don’t want the code of a particular code chunk to appear in the final 
# document, but still want to show the output (e.g. a plot), then you can include 
#echo = FALSE in the code chunk instructions.

```{r, echo = FALSE}
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)
```
# Similarly, you might want to create an object, but not include both the code 
# and the output in the final .html file. To do this you can use, include = FALSE. 
# Be aware though, when making reproducible research it’s often not a good idea 
# to completely hide some part of your analysis:
  
```{r, include = FALSE}
richness <-
  edidiv %>%
  group_by(taxonGroup) %>%
  summarise(Species_richness = n_distinct(taxonName))
```
# In some cases, when you load packages into RStudio, various warning messages 
# such as “Warning: package ‘dplyr’ was built under R version 3.4.4” might appear.
# If you do not want these warning messages to appear, you can use warning = FALSE.

```{r, warning = FALSE}
library(dplyr)
```
# REMEMBER: 
# R Markdown doesn’t pay attention to anything you have loaded in other R scripts, 
# you MUST load all objects and packages in the R Markdown script.

#### Inserting Figures ----
# Inserting a graph into RMarkdown is easy, the more energy-demanding aspect 
# might be adjusting the formatting.

# By default, RMarkdown will place graphs by maximising their height, while 
# keeping them within the margins of the page and maintaining aspect ratio. 
# If you have a particularly tall figure, this can mean a really huge graph. In 
# the following example we modify the dimensions of the figure we created above. 
# To manually set the figure dimensions, you can insert an instruction into the 
# curly braces:
  
```{r, fig.width = 4, fig.height = 3}
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)
boxplot(B~A,data=dataframe)
```
# Inserting Tables ----
# Standard R Markdown
# While R Markdown can print the contents of a data frame easily by enclosing 
# the name of the data frame in a code chunk:
  
```{r}
dataframe
```
# this can look a bit messy, especially with data frames with a lot of columns. 
# Including a formal table requires more effort.

# kable() function from knitr package
# The most aesthetically pleasing and simple table formatting function I have 
# found is kable() in the knitr package. The first argument tells kable to make 
# a table out of the object dataframe and that numbers should have two significant 
# figures. Remember to load the knitr package in your .Rmd file as well.

```{r}
library(knitr)
kable(dataframe, digits = 2)
```
# pander function from pander package
# If you want a bit more control over the content of your table you can use 
# pander() in the pander package. Imagine I want the 3rd column to appear in italics:
 
```{r}
library(pander)
plant <- c("a", "b", "c")
temperature <- c(20, 20, 20)
growth <- c(0.65, 0.95, 0.15)
dataframe <- data.frame(plant, temperature, growth)
emphasize.italics.cols(3)   # Make the 3rd column italics
pander(dataframe)           # Create the table
```

# 7. Create a .pdf file from your .Rmd file ----


# 8. R Notebooks (the future of reproducible code? Maybe?) ----


























 


