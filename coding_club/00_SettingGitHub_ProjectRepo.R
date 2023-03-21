##### REPOSITORY for PROJECT - set-up

# check and change the working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/coding_club")
getwd()

# install packages (if missing) for GitHub access - pick on of these
# install.packages('gitcreds')
# install.packages("credentials")

# set libraries for the project
library(usethis)
library(gitcreds)
library(credentials)

# check the active project directory
usethis::git_remotes()

# set the active project directory
usethis::use_git_remote(
  "origin",
  "git@github.com:tk51/r-playground.git", 
  overwrite = TRUE
) # tk51/---.git - put the repo name for work instead of "coding-demo.git"

# or there is another option as:
usethis::use_git_remote(
  "origin",
  "https://github.com/tk51/r-playground.git",
  overwrite = TRUE
) # tk51/....git - put the repo name for work instead of "coding-demo.git"

# check the active project directory
usethis::git_remotes()

# create a token for your repo
usethis::create_github_token() # then insert the token from GitHub site
# once obtained, the token should be inserted as password at connect to Git
# via RStudio

# set the token obtained from GitHub for your working repo
gitcreds::gitcreds_set() # insert your token in the terminal 

# check if a credential is stored
gitcreds::gitcreds_get() # insert your token in the terminal 

#check if a credential is stored - alternative with "credentials" package
credentials::set_github_pat()

# other functions than can help feeling confident with tokens (PAT)
gh::gh_whoami() # short notice
usethis::gh_token_help() # a bit longer notice
usethis::git_sitrep() # long notice

# if there are problems with environment, tokens can be saved in a file
usethis::edit_r_environ() # open and delete the stored ones, as they break
