#!/bin/bash

# Get the repository name
repo_name=$(basename `git rev-parse --show-toplevel 2>/dev/null`)

# Get the current branch name
branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# Check if inside a git repository
if [ -z "$repo_name" ] || [ -z "$branch_name" ]; then
    echo "---"
else
    echo "$repo_name|$branch_name"
fi
