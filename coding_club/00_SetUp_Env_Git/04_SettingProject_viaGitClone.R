# the APPROACH: GitHub first, than RStudio
# create a repo at GitHub, than proceed the set-up in RStudio
# this method sets up the local Git repo from immediate pulling and pushing.

# - make a repo at GitHub (public, with README for initialization)
# - copy the HTTPS of SSH clone URL
# - run this script or make a repo via New Project in RStudio...

# libraries
library(credentials)
library(usethis)
library(gitcreds)

# check the git repo set up for work
usethis::git_remotes()

# create NEW project from RStudio - paste URL from GitHub here
usethis::create_from_github(
  "https://github.com/TK51/coding-demo.git", # coding-demo = example
  destdir = "/home/t51/tmp"
)

# additional check commands
gh_token_help()

# credentials get and set in case of troubles with connection
gitcreds::gitcreds_get()
gitcreds::gitcreds_set()

# create new token in case there are problems connecting via the old one
usethis::create_github_token()
