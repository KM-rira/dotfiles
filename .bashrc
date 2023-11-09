# start vim
cat /c/vimStartScreen/vim.txt 

# pureline
source ~/vimConf/pureline/pureline ~/.pureline.conf

# git setting
HISTSIZE=100000
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '

# 非同期実行
nohup bash ~/vimConf/pull.sh > /dev/null 2>&1 &

# 他タブのhistoryを反映する
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -s histappend

# alias command
unalias -a

alias open='nvim ~/.bashrc'
alias ..='cd ..'
alias ...='cd ../..'
alias re='source ~/.bashrc'
alias bashrc='nv ~/.bashrc'
alias rc='nvim ~/AppData/Local/nvim/init.vim'
alias nv='nvim'
alias ll='ls -l --color=auto'
alias historygrep='history | grep'
alias got='go test -v -cover -run '

# git
alias status='git status'
alias push='git push'
alias checkout='git checkout'
alias branch='git branch'
alias fetch='git fetch'
alias log='git log --oneline'
alias fixup='git commit --fixup'
