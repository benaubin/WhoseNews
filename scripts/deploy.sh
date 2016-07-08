#!/bin/bash

if [ "$(git symbolic-ref --short HEAD)" != "master" ]
then
  echo "You can only deploy from master, not $(git symbolic-ref --short HEAD)."
  exit 0
fi

git add -A .
git -c user.name='Whose News Auto Deploy' -c user.email=whosenews@bensites.com commit -m "GitHub Pages deploy @$(git rev-parse --short HEAD)"
git push origin master
git subtree push --prefix build/homepage origin gh-pages
