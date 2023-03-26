#### Testing the R Markdown ###################################################
#install package and initiate the library
install.packages("rmarkdown")
library(rmarkdown)

# check the working directory and if needed change via setwd("/home/...")
getwd()

# check the files in it
list.files()

# set the output of the file in one of two options:
# - option one - includes HTML, .Rmd, and .md
## output:
##  html_document:
##    keep_md: true

# - option two - includes .Rmd and .md
## output: github_document

###############################################################################
# render file command
rmarkdown::render()

# Tell knitr to soldier on, even in the presence of errors. Some problems are 
# easier to diagnose if you can execute specific R statements during rendering 
# and leave more evidence behind for forensic examination.
# Insert this chunk near the top of your .Rmd document:

# ```{r setup, include = FALSE, cache = FALSE}
# knitr::opts_chunk$set(error = TRUE)
# ```

# If it’s undesirable to globally accept errors, you can still specify 
# error = TRUE for a specific chunk like so:

# ```{r wing-and-a-prayer, error = TRUE}
## your sketchy code goes here ;)
# ```

# Adapt the “git bisect” strategy:
# Put knitr::knit_exit() somewhere early in your .Rmd document, 
# either in inline R code or in a chunk. Keep moving it earlier until things 
# work. Now move it down in the document. Eventually you’ll be able to narrow 
# down the location of your broken code well enough to find the line(s) and 
# fix it.

###############################################################################
### Transform R Markdown into R Script
# - save file as .Rmd -> .R




