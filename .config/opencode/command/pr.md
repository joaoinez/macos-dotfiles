---
description: create a pull request to a target branch
model: github-copilot/claude-sonnet
---

Create a pull request from the current branch to the target branch.

**Target branch**: `$1` (if empty, use `main` as the default target branch)

## Pre-flight checks

First, check the status of the current branch for any uncommitted changes or
sync issues with remote:

Current branch:
!`git branch --show-current`

Git status (uncommitted changes):
!`git status --short`

Fetch latest from remote and check sync status:
!`git fetch origin`
!`git status --branch --short`

**IMPORTANT**: Before proceeding, review the above output:

- If there are uncommitted changes (files listed in git status), prompt me about
whether to commit them first or proceed anyway
- If the branch is behind remote (e.g., "behind 3"), prompt me about whether to
pull first or proceed anyway
- If the branch is ahead of remote (e.g., "ahead 2"), prompt me about wheter to
push first or proceed anyway
- Only proceed with the PR creation after I confirm or if everything looks clean

---

After the pre-flight checks are resolved, fetch the target branch:
!`git fetch origin $1`

Here is the current branch name (use this as the PR title):
!`git branch --show-current`

Here are the changes between the current branch and the target branch:
!`git diff $1...HEAD`

Here are the commits that will be included in this PR:
!`git log $1..HEAD --oneline`

## Creating the PR

Use `gh pr create` to create the pull request with the following:

**Title**: Use the current branch name

**Body structure**:

```
## Summary
- <bullet points describing the changes>

## Test plan
- [ ] <checkbox items for testing>
```

**Guidelines for writing the PR body**:

- Prefer to explain WHY something was done from an end user perspective instead
of WHAT was done
- Do not use generic messages like "improved agent experience" - be very
specific about what user-facing changes were made
- Each summary bullet should describe a meaningful change from the user's
perspective
- Each test plan item should be a specific, actionable verification step

Use this command format:

```
gh pr create --base $1 --title "<branch-name>" --body "<body-content>"
```
