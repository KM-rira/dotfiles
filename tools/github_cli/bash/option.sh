#!/bin/bash

# 引数の数をチェック
case "$#" in
    *)
        for arg in "$@"; do
            case "$arg" in
                a)
                    Type='--state all'
                    ;;
                o)
                    Type='--state open'
                    ;;
                c)
                    Type='--state closed'
                    ;;
                d)
                    Type='--draft'
                    ;;
                s)
                    select_repo_flg=true
                    ;;
                [1-9]*)
                    Limit2=$arg
                    ;;
            esac
        done
        ;;
esac