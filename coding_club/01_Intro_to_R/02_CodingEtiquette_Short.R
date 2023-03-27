# the basic script structure ----
# - the introduction
# - libraries
# - functions
# - working directory
# - loaded data
# - the different sections of your analysis: logical development
# - the outputs of your analysis

# outline example ----

# - the introduction ---
# - libraries ---
# - functions ---
# - working directory ---
# - loaded data ---
# The different sections of your analysis: logical development
# - Formatting data ---
# - Calculate summary stats ---
# - Visualizing the ...with ggplot2 package ---
# - The outputs of your analysis ---

# file naming ----
# -- Object names should be concise and meaningful.Long object names are annoying 
# to type. More letters = higher chance you’ll make a typo.
# -- Variable names should be nouns. e.g. abundance richness
# -- Function names should be verbs. e.g. calc.sp.richness
# -- Use an underscore to separate words within a script file. e.g. 
# LPI_analysis_Apr_2017.R
# -- The preferred form for object/variable names is all lower case letters 
# and words separated with underscores e.g. (object_name$variable_name).
# -- For functions, all lower case letters and words separated by dots e.g. 
# (function.name).

# - example: Object names
avg_clicks  # Good.
avg.clicks  # Acceptable.
avg_Clicks  # Not okay.

# - example: Function names
calculate.avg.clicks  # This is what we are aiming for.
CalculateAvgClicks  # Not that bad, but mixing capital and lowercase letters 
# can lead to typos
calculate_avg_clicks , calculateAvgClicks  # Bad. The convention is that 
# functions are defined using dots, not underscores.

# spacing ----
# -- Place spaces around all infix operators (=, +, -, <-, etc.). The same rule 
# applies when using = in function calls. Always put a space after a comma, 
# and never before, just like in normal prose.
# -- Don’t place a space before left parentheses, except in a function call.
# -- Extra spacing (i.e., more than one space in a row) is ok if it improves 
# alignment of equal signs or assignments (<-).
# -- Do not place spaces around code in parentheses or square brackets (unless 
# there’s a comma, in which case see above).
# -- Inline commenting: If you are commenting inline with code, place two spaces
# after the code, followed by #, a single space and then your text, e.g. 
# summary(model)<space><space>#<space>comment.

# curly braces ----
# -- An opening curly brace should never go on its own line and should always 
# be followed by a new line. A closing curly brace should always go on its own 
# line, unless it’s followed by else. Always indent the code inside curly braces.

# line length ----
# -- The official convention is to limit your code to 80 characters per line. 
# -- How do you know what’s 80 characters though? RStudio can place a handy line 
# in your editor as a reminder! Go to 
# Tools/Global Options/Code/Display/Show Margin/80 characters. 
# -- When using pipes from the dplyr package, keep the pipe operator %>% at the 
# end of the line and continue your pipe on a new line.
# -- When using ggplot2, keep the + at the end of the line and continue 
# adding on layers on a new line.


# general advice ----
# - create folder "img" manually in working directory for images

# shortcuts ----
# - Ctrl + Shift + O - outline pane
# - Alt + L - collapse
# - Alt + Shift + L - expand
# - Alt + O - collapse all
# - Alt + Shift + O - expand all