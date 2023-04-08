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

# 7. Create a .pdf file from your .Rmd file ----


# 8. R Notebooks (the future of reproducible code? Maybe?) ----


























 


