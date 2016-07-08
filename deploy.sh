#!/bin/bash

if [ "$(git symbolic-ref --short HEAD)" != "master" ]
then
  echo "This commit was made against the $(git symbolic-ref --short HEAD) and not the master! No deploy!"
  exit 0
fi

git add -A .
git commit -c user.name='Whose News Auto Deploy' -c user.email=whosenews@bensites.com -m "GitHub Pages deploy @${git rev-parse --short HEAD}"
git push origin master
git subtree push --prefix build/homepage origin gh-pages
