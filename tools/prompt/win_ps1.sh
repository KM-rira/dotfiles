#!/bin/bash

# Color definitions
BLACK='\[\033[0;30m\]'
DARK_GRAY='\[\033[1;30m\]'
RED='\[\033[0;31m\]'
LIGHT_RED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHT_GREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHT_BLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
LIGHT_PURPLE='\[\033[1;35m\]'
CYAN='\[\033[0;36m\]'
LIGHT_CYAN='\[\033[1;36m\]'
LIGHT_GRAY='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
RESET='\[\033[0m\]'

# Function to get the current Git branch name
parse_git_branch() {
    branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //')
    echo "$branch"
}

# Function to get the number of changes, untracked files, staged files, and commits ahead
parse_git_changes() {
    local branch=$(parse_git_branch)
    if [ -n "$branch" ]; then
        local changes=$(git diff --name-only 2>/dev/null | wc -l)
        local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
        local staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
        local commits_ahead=$(git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD)
        echo "⚙  $changes 🆕 $untracked 📂 $staged 📝 $commits_ahead"
    fi
}

# Function to set the color for changes
changes_color() {
    local branch=$(parse_git_branch)
    if [ -n "$branch" ]; then
        local changes=$(git diff --name-only 2>/dev/null | wc -l)
        if [ $changes -gt 0 ]; then
            echo -n "${LIGHT_GREEN}"
        else
            echo -n "${LIGHT_PURPLE}"
        fi
    fi
}

# Function to count changes
changes_count() {
    local branch=$(parse_git_branch)
    if [ -n "$branch" ]; then
        git diff --name-only 2>/dev/null | wc -l
    else
        echo 0
    fi
}

# Function to count untracked files
untracked_count() {
    local branch=$(parse_git_branch)
    if [ -n "$branch" ]; then
        git ls-files --others --exclude-standard 2>/dev/null | wc -l
    else
        echo 0
    fi
}

# Function to count staged files
staged_count() {
    local branch=$(parse_git_branch)
    if [ -n "$branch" ]; then
        git diff --cached --name-only 2>/dev/null | wc -l
    else
        echo 0
    fi
}

# Function to count commits ahead
commits_ahead_count() {
    local branch=$(parse_git_branch)
    if [ -n "$branch" ]; then
        git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD
    else
        echo 0
    fi
}

# Function to set the PS1 variable
set_color() {
    local default="${GREEN}\u${YELLOW}@${CYAN}\h${LIGHT_BLUE}:\w ${LIGHT_RED}$(parse_git_branch) "
    local tail="${RED}\\n$ ${RESET}"

    local changes_color=$(changes_color)
    local changes_result=$(parse_git_changes)

    PS1="${default}${changes_color}${changes_result}${tail}"
}

PROMPT_COMMAND=set_color
