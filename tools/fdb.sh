#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "===== need parameter ====="
    exit
fi

select_file=$(fdfind $@ | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi)

if [ -z "$select_file" ] ; then
    echo "===== exit process ====="
    exit
fi

batcat $select_file

