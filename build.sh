#! /usr/bin/env bash

set -e

# Assumes composer.lock present
composer install -q --no-interaction --prefer-dist --optimize-autoloader --no-dev

# Assumes package-lock.json present
npm ci
npm run build

# Create a deploy-read artifact
git archive -o "builds/$(git rev-parse HEAD).zip" HEAD

# Add in needed .gitignore'd or .gitattribute export-ignore'd files
zip -qur "builds/$(git rev-parse HEAD).zip" vendor

# Uncomment this to include built static assets if they are
# .gitignore'd (common in team environments)
## zip -qur "builds/$(git rev-parse HEAD).zip" public/build

