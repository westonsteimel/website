#!/bin/bash
set -e
set -o pipefail

echo -e "\033[0;32mDeploying updates to westonsteimel.github.io...\033[0m"

# Build the project using hugo in docker.
docker run --rm \
    -v "$PWD:/site" \
    --workdir /site \
    --name hugo-website-builder \
    westonsteimel/hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
(
# Go To Public folder
cd public || exit
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -s -m "$msg"

# Push source and build repos.
git push origin master
)
