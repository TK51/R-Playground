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




# general advice ----
# - create folder "img" manually in working directory for images

# shortcuts ----
# - Ctrl + Shift + O - outline pane
# - Alt + L - collapse
# - Alt + Shift + L - expand
# - Alt + O - collapse all
# - Alt + Shift + O - expand all