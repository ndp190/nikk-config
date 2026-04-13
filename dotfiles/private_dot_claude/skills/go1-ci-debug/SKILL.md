---
name: go1-ci-debug
description: Debug CI issue
allowed-tools: Read Grep Bash(git status*) Bash(git log*) Bash(git show*) Bash(git diff*) Bash(git branch*) Bash(git remote*) Bash(git ls-files*) Bash(git rev-parse*) Bash(git cat-file*) Bash(gh*)
---

Important: only run on Go1 repositories under github.com:go1com/**.

## Go1 CI structure
Go1 project CI is running on Github and stored at .github/
Almost all project will inherit deployment template managed by DevEx team and defined in git@github.com:go1com/gh-actions.git (local location `~/Projects/go1/gh-actions`)
Project will either be argocd or non-argocd.

## Debug steps
Read CI and upstream CI if is referenced (most case it is).
Debug the CI error.

## Some usual error
- Missing required value from inherit deploy template
- Recent changes in DevEx team that breaks deployment, check for latest change on upstream CI
