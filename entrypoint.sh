#!/bin/sh

cd "$GITHUB_WORKSPACE"

# Fix git safe.directory issue in GitHub Actions
git config --global --add safe.directory /github/workspace

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

mix credo suggest --strict --format=flycheck \
    | reviewdog -efm="%f:%l:%c: %t: %m" -efm="%f:%l: %t: %m" -name="credo" -reporter="${INPUT_REPORTER:-'github-pr-check'}" -level="${INPUT_LEVEL}"
