#!/bin/bash

# 色の定義
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

# Gitブランチ名を取得する関数
parse_git_branch() {
    branch=$(git branch 2>/dev/null | grep '*' | sed 's/* //')
    result=" $branch"
    echo "$result"
}

# Gitの変更ファイル数、未追跡ファイル数、ステージングファイル数を取得する関数
parse_git_changes() {
    local branch=$(parse_git_branch)
    if [ " " != "$branch" ]; then
        local changes=$(git diff --name-only 2>/dev/null | wc -l)
        local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
        local staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
        local commits_ahead=$(git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD)
        local result=""

        result="⚙  $changes 🆕 $untracked 📂 $staged 📝 $commits_ahead"

        echo "$result"
    fi
}

changes_result() {
    local branch=$(parse_git_branch)
    changes=0
    if [ " " != "$branch" ]; then
        changes=$(git diff --name-only 2>/dev/null | wc -l)
        result=" ⚙  $changes"
        echo "$result"
    fi
}

untracked_result() {
    local branch=$(parse_git_branch)
    untracked=0
    if [ " " != "$branch" ]; then
        untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
        result=" 🆕 $untracked"
        echo "$result"
    fi
}

staged_result() {
    local branch=$(parse_git_branch)
    staged=0
    if [ " " != "$branch" ]; then
        staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
        result=" 📂 $staged"
        echo "$result"
    fi
}

commits_ahead_result() {
    local branch=$(parse_git_branch)
    commits_ahead=0
    if [ " " != "$branch" ]; then
        commits_ahead=$(git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD)
        result=" 📝 $commits_ahead"
        echo "$result"
    fi
}

changes_color() {
    local branch=$(parse_git_branch)
    if [ " " != "$branch" ]; then
        local changes=$(git diff --name-only 2>/dev/null | wc -l)
        if [ $changes -gt 0 ]; then
            echo -n "${LIGHT_GREEN}"
        else
            echo -n "${LIGHT_PURPLE}"
        fi
    fi
}

changes_count() {
    local branch=$(parse_git_branch)
    changes_c=0
    if [ " " != "$branch" ]; then
        changes_c=$(git diff --name-only 2>/dev/null | wc -l)
        echo "$changes_c"
    else
        echo "$changes_c"
    fi
}

untracked_count() {
    local branch=$(parse_git_branch)
    untracked_c=0
    if [ " " != "$untracked" ]; then
        untracked_c=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
        echo "$untracked_c"
    else
        echo "$untracked_c"
    fi
}

staged_count() {
    local branch=$(parse_git_branch)
    staged_c=0
    if [ " " != "$branch" ]; then
        staged_c=$(git diff --cached --name-only 2>/dev/null | wc -l)
        echo "$staged_c"
    else
        echo "$staged_c"
    fi
}

commits_ahead_count() {
    local branch=$(parse_git_branch)
    commits_ahead_c=0
    if [ " " != "$branch" ]; then
        commits_ahead_c=$(git rev-list --count origin/$(git rev-parse --abbrev-ref HEAD)..HEAD)
        echo "$commits_ahead_c"
    else
        echo "$commits_ahead_c"
    fi
}

head_brackets_status() {
    local branch=$(parse_git_branch)
    if [ " " != "$branch" ]; then
        echo "("
    fi
}

end_brackets_status() {
    local branch=$(parse_git_branch)
    if [ " " != "$branch" ]; then
        echo ")"
    fi
}



set_color() {
    default="${GREEN}\u${YELLOW}@${CYAN}\h${LIGHT_BLUE}:\w${LIGHT_RED}\$(parse_git_branch) "
    tail="${RED}\\n$ ${RESET}"

    if [ "$(changes_count)" -gt 0 ]; then
        changes_color="${LIGHT_GREEN}"
    else
        changes_color="${LIGHT_PURPLE}"
    fi

    if [ "$(untracked_count)" -gt 0 ]; then
        untracked_color="${LIGHT_GREEN}"
    else
        untracked_color="${LIGHT_PURPLE}"
    fi

    if [ $(staged_count) -gt 0 ]; then
        staged_color="${LIGHT_GREEN}"
    else
        staged_color="${LIGHT_PURPLE}"
    fi

    if [ $(commits_ahead_count) -gt 0 ]; then
        commits_ahead_color="${LIGHT_GREEN}"
    else
        commits_ahead_color="${LIGHT_PURPLE}"
    fi
    PS1="${default}${changes_color}\$(changes_result)${untracked_color}\$(untracked_result)${staged_color}\$(staged_result)${commits_ahead_color}\$(commits_ahead_result)${tail}"
}

PROMPT_COMMAND=set_color
# \u: ユーザー名
# \h: ホスト名
# \w: カレントディレクトリ
# \$(parse_git_branch): 現在のGitブランチ名
# \$(parse_git_changes): Gitの変更ファイル数、未追跡ファイル数、ステージングファイル数、プッシュされる前にコミットされた数
# \$: 標準ユーザーの場合は $、root ユーザーの場合は #
