#!/bin/bash
cd "$(dirname "$0")" || exit 1

git add .

if [ -z "$1" ]; then
  echo "Error: Please provide a commit message using Conventional Commits."
  echo "Usage: ./push.sh \"feat(scope): description\""
  exit 1
fi

git commit -m "$1"
git push origin master
