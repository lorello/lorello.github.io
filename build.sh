#!/bin/bash

set -e

git checkout mkdocs

BASEURL=https://github.com/lorello/lorello.github.io/commit

git log --abbrev-commit --pretty=format:"* %an commit <$BASEURL/%H|%h> di %ar: %B" --after='$(date --date="1 month ago" +%Y-%m-%d)'| sed ':a;N;$!ba;s/\n\n/\n/g' > ./docs/changelog.md

git commit -m "Updated changelog" ./docs/changelog.md

git push origin mkdocs

# GitHub personal page: https://github.com/mkdocs/mkdocs/issues/354
mkdocs gh-deploy --clean 
