##### FIRST SET-UP with GitHub installation and adjustments ###############
# change the working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground/coding_club")
getwd()

# git library
library(usethis)

# check git and it's version (if any) in Terminal
## which git
## git --version

# install Git if you don't have one via Terminal
## sudo apt-get install git

# in Terminal set your name and mail (same could be done via RStudio later), 
# associated with your account at Git
## git config -- global user.name "your.name"
## git config -- global user.mail "your.mail@mail.com"
## git config -- global --list

# otherwise, config can be set up via 'usethis' package

# install the package for GitHub access - pick on of these
# install.packages('gitcreds')
library(gitcreds)
# install.packages("credentials")
library(credentials)

# set git config for user and mail
use_git_config(user.name = "tk51", user.email = "t.khamardiuk@gmail.com")

# set default initial branch to "main" in the terminal:
## git config --global init.defaultBranch main

# or in RStudio - default for name is "main"
usethis::git_default_branch_configure()

# install GitHub desktop client via Terminal
## sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.1.1-linux1/GitHubDesktop-linux-3.1.1-linux1.deb^C

# unpack and install the file downloaded via Terminal
## sudo dpkg -i GitHubDesktop-linux-3.1.1-linux1.deb

# check the active project directory
usethis::git_remotes()

# set the active project directory
usethis::use_git_remote(
  "origin",
  "git@github.com:tk51/coding-demo.git", 
  overwrite = TRUE
) # tk51/....git - put the repo name for work instead of "coding-demo.git"

# or there is another option as:
usethis::use_git_remote(
  "origin",
  "https://github.com/tk51/coding-demo.git",
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

# if there are problems with environment, tokens can be stored in a file
usethis::edit_r_environ()























