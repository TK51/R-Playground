#### Testing the R Markdown ###################################################
# check the working directory and if needed change via setwd("/home/...")
getwd()

# check the GitHub connectivity and make changes if needed...
usethis::git_remotes()

# check the token available
gitcreds::gitcreds_get()

# create token if needed  and set up via 
# usethis::create_github_token()
# gitcreds::gitcreds_set()
###############################################################################

