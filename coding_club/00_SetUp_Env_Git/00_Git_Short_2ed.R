#### Testing the R Markdown #################################################
# check the working directory and if needed change via setwd("/home/...")
getwd()

# check the GitHub connectivity and make changes if needed...
usethis::git_remotes()

# check the token available
gitcreds::gitcreds_get()

# make new token
usethis::create_github_token()

#set the token obtained
gitcreds::gitcreds_get()

# check again the token
gitcreds::gitcreds_set()
############################################################################
### terminal activities for committing updates to GitHub
# - git status
# - git add .
# - git commit -m "your-message-about-the-update"
# - git push

### terminal specific hint-command
# - git remote set-url origin https://github.com/TK51/R-Playground.git
# - git remote show origin
############################################################################