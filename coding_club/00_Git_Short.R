getwd()
setwd("/home/t51/tmp")

usethis::git_remotes()

# or there is another option as:
  usethis::use_git_remote(
    "origin",
    "https://github.com/tk51/r-playground.git",
    overwrite = TRUE
  ) # tk51/....git - put the repo name for work instead of "coding-demo.git"

# check the active project directory
usethis::git_remotes()

gitcreds::gitcreds_get() 

usethis::create_github_token()

gitcreds::gitcreds_set() 

credentials::set_github_pat()
