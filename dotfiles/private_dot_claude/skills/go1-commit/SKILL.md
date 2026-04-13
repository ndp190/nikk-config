---
name: go1-commit
description: Commit code to go1 repositories guideline
allowed-tools: Read Grep Bash(git status*) Bash(git log*) Bash(git show*) Bash(git diff*) Bash(git branch*) Bash(git remote*) Bash(git ls-files*) Bash(git rev-parse*) Bash(git cat-file*) Bash(gh*)
---

Important: only run on Go1 repositories under github.com:go1com/**.

## git commit format
- Title: <branch-jira-code> generated-title
    - <branch-jira-code> - extracted from current branch if existed and is in format of AA-1234 (e.g. branch name is DO-1234-change-sth -> branch-jira-code is DO-1234
- Description: generated description about the changes, keep it concise, to the point or don't add description at all when not needed

## how to commit

Give user the git command to commit, DO NOT DO commit yourself.
Do not add co-authored.
