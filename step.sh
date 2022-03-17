#!/bin/bash

# Get the current branch so we can return to it:
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Check out each commit from oldest commit to newest:
GIT_HASHES=($(git --no-pager log --reverse --pretty=format:%h))
for index in ${!GIT_HASHES[@]}; do
  GIT_HASH=${GIT_HASHES[$index]}
  (( HASH_NUM = $index + 1))
  echo "Commit $HASH_NUM of ${#GIT_HASHES[@]}"
  git -c advice.detachedHead=false checkout $GIT_HASH
  printf "Press enter when you're ready for the next commit"
  read input
done

# Exit detached HEAD:
git checkout $GIT_BRANCH
