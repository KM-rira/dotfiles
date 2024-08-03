# 色の定義
BLACK=$'%{\e[0;30m%}'
DARK_GRAY=$'%{\e[1;30m%}'
RED=$'%{\e[0;31m%}'
LIGHT_RED=$'%{\e[1;31m%}'
GREEN=$'%{\e[0;32m%}'
LIGHT_GREEN=$'%{\e[1;32m%}'
BROWN=$'%{\e[0;33m%}'
YELLOW=$'%{\e[1;33m%}'
BLUE=$'%{\e[0;34m%}'
LIGHT_BLUE=$'%{\e[1;34m%}'
PURPLE=$'%{\e[0;35m%}'
LIGHT_PURPLE=$'%{\e[1;35m%}'
CYAN=$'%{\e[0;36m%}'
LIGHT_CYAN=$'%{\e[1;36m%}'
LIGHT_GRAY=$'%{\e[0;37m%}'
WHITE=$'%{\e[1;37m%}'
RESET=$'%{\e[0m%}'

# Gitブランチ名を取得する関数
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Gitの変更ファイル数、未追跡ファイル数、ステージングファイル数を取得する関数
parse_git_changes() {
    local branch=$(parse_git_branch)
    if [[ -n "$branch" ]]; then
        local changes=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
        local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
        local staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
        local commits_ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
        echo " 🔨 $changes 🆕 $untracked 📂 $staged 📝 $commits_ahead"
    fi
}

# 各種カウントを取得する関数
get_count() {
    local branch=$(parse_git_branch)
    if [[ -n "$branch" ]]; then
        case $1 in
            changes)
                git diff --name-only 2>/dev/null | wc -l | tr -d ' '
                ;;
            untracked)
                git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' '
                ;;
            staged)
                git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' '
                ;;
            commits_ahead)
                git rev-list --count @{u}..HEAD 2>/dev/null || echo "0"
                ;;
        esac
    else
        echo "0"
    fi
}

# プロンプトの色を設定する関数
set_prompt_color() {
    local changes_count=$(get_count changes)
    local untracked_count=$(get_count untracked)
    local staged_count=$(get_count staged)
    local commits_ahead_count=$(get_count commits_ahead)

    local changes_color="${DARK_GRAY}"
    local untracked_color="${DARK_GRAY}"
    local staged_color="${DARK_GRAY}"
    local commits_ahead_color="${DARK_GRAY}"

    [[ "$changes_count" -gt 0 ]] && changes_color="${LIGHT_GREEN}"
    [[ "$untracked_count" -gt 0 ]] && untracked_color="${LIGHT_GREEN}"
    [[ "$staged_count" -gt 0 ]] && staged_color="${LIGHT_GREEN}"
    [[ "$commits_ahead_count" -gt 0 ]] && commits_ahead_color="${LIGHT_GREEN}"

    local git_info=""
    [[ -n "$(parse_git_branch)" ]] && git_info="${BROWN}$(parse_git_branch)${changes_color} 🔨 ${changes_count}${untracked_color} 🆕 ${untracked_count}${staged_color} 📂 ${staged_count}${commits_ahead_color} 📝 ${commits_ahead_count}"

    PROMPT="${CYAN}%~${git_info}${YELLOW}
$ ${RESET}"
}

# プロンプトを更新する前に set_prompt_color 関数を呼び出す
precmd() { set_prompt_color }
