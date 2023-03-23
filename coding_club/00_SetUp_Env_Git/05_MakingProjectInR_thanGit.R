# Studio first, GitHub second

# Open new RStudio session

# check the working directory and change it to a desired place
getwd()
setwd("/home/t51/tmp") # "/path/to/your/project"
getwd()

# make a Project in RStudio
usethis::create_project(
  "/home/t51/tmp/new-repo" # "/path/to/your/project"
)

# if there is a Git pane in Environments section - set up is OK
# if not, make or verify Git repo
usethis::use_git()
usethis::use_github()

usethis::git_remotes()

# or there is another option as:
usethis::use_git_remote(
  "origin",
  "https://github.com/tk51/new-repo.git",
  overwrite = TRUE
) # tk51/---.git - put the repo name for work instead of "new-repo.git"

# check the active project directory
usethis::git_remotes()

gitcreds::gitcreds_get() 

usethis::create_github_token()

gitcreds::gitcreds_set() 

credentials::set_github_pat()

### terminal activities for committing updates to GitHub
# - git status
# - git add .
# - git commit -m "your-message-about-the-update"
# - git push

### terminal specific hint-command
# - git remote set-url origin https://github.com/TK51/new-repo.git
# - git remote show origin
