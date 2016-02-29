# Git Versioning System

## Config

    git config --global http.postBuffer 1024000000

## Change Log generation

List file names changed between two revisions IDs

    git diff $oldrev $newrev --diff-filter=ACDMR --name-only

List changes between two revisions IDs, with author and commit message

    # sed removes double \n that come from git log (%B)
    git log --abbrev-commit --pretty=format:'* %h %an %ar: %B' ${oldrev}..${newrev} | sed ':a;N;$!ba;s/\n\n/\n/g'

List changes after a specified date, with author and commit message

    git log --abbrev-commit --pretty=format:'* %h %an %ar: %B' --after='2016-02-01'| sed ':a;N;$!ba;s/\n\n/\n/g'

A changelog for Slack chat

    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    HOSTNAME=$(hostname -f)

    # Links to changed files
    FILES_CHANGED=''
    for ITEM in $(git diff $oldrev $newrev --diff-filter=ACDMR --name-only); do
      FILES_CHANGED="$FILES_CHANGED\n* <$GIT_REPO/blob/$newrev/$ITEM|$ITEM>"
    done

    NUM_CHANGED=$(git diff $oldrev $newrev --diff-filter=ACDMR --name-only | wc -l)
    BASEURL="$GIT_REPO/commit"

    GITLOG=$(git log --abbrev-commit --pretty=format:"* %an commit <$BASEURL/%H|%h> di %ar: %B" ${oldrev}..${newrev} | sed ':a;N;$!ba;s/\n\n/\n/g')

    CHANGELOG="*$NUM_CHANGED* files changed:\n$FILES_CHANGED\n\n*Details*:\n$GITLOG\n"
