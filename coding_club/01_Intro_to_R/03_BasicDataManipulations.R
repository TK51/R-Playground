#### Basic Data Manipulation ----
# 1. Learn base R syntax for data manipulation:
# --- logical operators for finer control
# --- creating and assigning objects
# --- specifying factors
# 2. Turn messy data into tidy data with tidyr
# 3. Use efficient tools from the dplyr package to manipulate data

#### 1. Subset, extract and modify data with R operators ----

# create empty script, fill intro (title, web-link, data, author)
# set working directory
# load the data
# examine superficially the data loaded (head, str, dim...)
# -- access variables via $ and [ , ]
# -- in brackets first stands for row, the second for column
# -- single value gives the whole row or the whole column
# modify the data:
# -- creating intermediary objects
# -- renaming the columns using names()
# -- creating factors & changing factor levels (as.factor() & levels() ...)

#### 2. TIDYR: What is tidy data, and how do we achieve it? ----
# getting the tidyr package initialized
# deciding on long or wide data appearance - gather() vs spread()
# getting the data in the right format, it can be visualized then...

#### 3. DPLYR: Explore the most common and useful functions of dplyr ----
# -- rename() variables
# -- filter() rows and select() columns - sub-setting & selecting out
# use the notation dplyr::select() to avoid clashes with other packages
# -- mutate() your dataset by creating new columns
# -- group_by() certain factors to perform operations on chunks of data
# -- summarise() data with a range of summary statistics
# -- ..._join() datasets based on shared attributes






