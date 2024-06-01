# ~/.bashrc or ~/.bash_profile

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
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

# Gitの変更ファイル数、未追跡ファイル数、ステージングファイル数を取得する関数
parse_git_changes() {
  local branch=$(parse_git_branch)
  if [ -n "$branch" ]; then
    local changes=$(git diff --name-only 2>/dev/null | wc -l)
    local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
    local staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
    local result=""

    result="⚙️ $changes 🆕 $untracked 🗂️ $staged"

    echo "$result"
  fi
}

# カスタマイズされたプロンプト
PS1="${GREEN}\u${YELLOW}@${CYAN}\h${BLUE}:\w ${LIGHT_RED}\$(parse_git_branch) ${LIGHT_PURPLE}\$(parse_git_changes) ${RED}\$ ${RESET}"

# \u: ユーザー名
# \h: ホスト名
# \w: カレントディレクトリ
# \$(parse_git_branch): 現在のGitブランチ名
# \$(parse_git_changes): Gitの変更ファイル数、未追跡ファイル数、ステージングファイル数（ブランチが存在する場合のみ）
# \$: 標準ユーザーの場合は $、root ユーザーの場合は #
