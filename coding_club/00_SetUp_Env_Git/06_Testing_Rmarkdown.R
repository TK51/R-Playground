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

# Transform the R markdown to R:
  
#  Anything that’s not R code? Like the YAML and the prose? Protect it with 
# roxygen-style comments: start each line with #'.

# Anything that is R code? Let it exist “as is” as top-level code. 
# That means you’ll need to change the syntax of R chunk headers like so:
  
#  Before: ```{r setup, include = FALSE}
# After: #+ r setup, include = FALSE
  
#  Replace the leading backticks and opening curly brace with #+.
# Delete the trailing curly brace.
# Delete the 3 backticks that end each chunk.

# Render the R script through one of these methods:
  
#  Click on the “notebook” icon in RStudio to “Compile Report”.
# In RStudio, do File > Knit Document.
# In R, do rmarkdown::render("foo.R").

getwd() # check the working directory before making the render

#'render the file mentioning it's full path
rmarkdown::render("/home/t51/DataAnalytics/R-Playground/markdown_workshop/foo.R")


#'#############################################################################
#' render the file mentioning it's full path - 
#' **rmarkdown::render***("/path/to/your/foo.R")*
#' 
#' as mine is like that: - 
#' **rmarkdown::render***("/.../markdown_workshop/foo.R")*
