# the APPROACH: GitHub first, than RStudio
# create a repo at GitHub, than proceed the set-up in RStudio

# libraries
library(credentials)
library(usethis)
library(gitcreds)

# check the git repo set up for work
usethis::git_remotes()

# create NEW project from RStudio
usethis::create_from_github(
  "https://github.com/TK51/coding-demo.git",
  destdir = "~/home/tmp/coding-demo/"
)

# additional check commands
gh_token_help()

# credentials get and set in case of troubles with connection
gitcreds::gitcreds_get()
gitcreds::gitcreds_set()

# create new token in case there are problems connecting via the old one
usethis::create_github_token()
