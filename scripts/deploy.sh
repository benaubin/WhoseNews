#!/bin/bash


if [[ "$TRAVIS_BRANCH" != "master" ]]
then
  echo "You can only deploy from master." >&2
  exit 0
fi

$commit = `git rev-parse --short HEAD`

cd build/homepage
git init
git add .
git -c user.name='Whose News Auto Deploy' -c user.email=whosenews@bensites.com commit -m "GitHub Pages deploy @$commit"
git push --force --quiet "https://${GH_TOKEN}@github.com/penne12/WhoseNews.git" master:gh-pages