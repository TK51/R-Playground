# check the working directory
getwd()
setwd("/home/t51/DataAnalytics/R-Playground")

# check the remote set up
usethis::git_remotes()

# or there is another option as:
  usethis::use_git_remote(
    "origin",
    "https://github.com/tk51/r-playground.git",
    overwrite = TRUE
  ) # tk51/---.git - put the repo name for work instead of "r-playground.git"

# check the active project directory
usethis::git_remotes()0

# check the credentials set up
gitcreds::gitcreds_get() 

# create token if needed
usethis::create_github_token()

# set the token into the register
gitcreds::gitcreds_set() 

# here is an optional command
credentials::set_github_pat()

### terminal activities for committing updates to GitHub
# - git status
# - git add .
# - git commit -m "your-message-about-the-update"
# - git push

### terminal specific hint-command0

# - git remote set-url origin https://github.com/TK51/R-Playground.git
# - git remote show origin