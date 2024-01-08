#! /usr/bin/env bash

set -e

# Assumes composer.lock present
composer install -q --no-interaction --prefer-dist --optimize-autoloader --no-dev

# Assumes package-lock.json present
npm ci
npm run build

# Note that $GITHUB_SHA is set by GitHub Actions
# For local testing, run:
# `GITHUB_SHA=$(git rev-parse HEAD) ./build.sh``

# Create a deploy-read artifact
git archive -o "builds/$GITHUB_SHA.zip" HEAD

# Add in needed .gitignore'd or .gitattribute export-ignore'd files
zip -qur "builds/$GITHUB_SHA.zip" vendor

# Uncomment this to include built static assets if they are
# .gitignore'd (common in team environments)
## zip -qur "builds/$GITHUB_SHA.zip" public/build

