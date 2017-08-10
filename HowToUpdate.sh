# Download and install git from
https://git-scm.com/downloads

# Then execute gitbash and go to git folder
$ cd "C:\Users\final\Desktop\Git"

# Then clone this repository with http protocol
$ git clone http://bitbucket.org/utilone/ $repositoryname .git

# Go to Python folder
$ cd $repositoryname

# Add, Delete or Update your changes on files
# Can check status with
$ git status

# After changes add all of them
$ git add --all

# Commit your changes
$ git commit -m "changes comment"

# Send your changes to Bitbucket
$ git push origin master
