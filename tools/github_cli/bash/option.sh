#!/bin/bash

# 引数の数をチェック
case "$#" in
    *)
        for arg in "$@"; do
            case "$arg" in
                a|-a)
                    Type='--state all'
                    ;;
                o|-o)
                    Type='--state open'
                    ;;
                c|-c)
                    Type='--state closed'
                    ;;
                d|-d)
                    Type='--draft'
                    ;;
                e|-e)
                    error_only_flg=true
                    ;;
                s|-s)
                    select_repo_flg=true
                    ;;
                [1-9]*)
                    Limit2=$arg
                    ;;
            esac
        done
        ;;
esac