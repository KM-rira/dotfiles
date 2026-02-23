#!/bin/bash

source ~/dotfiles/tools/github_cli/bash/config.sh
source ~/dotfiles/tools/github_cli/bash/option.sh

# Gitリポジトリのorigin URLを取得
repo_url=$(git config --get remote.origin.url)

# URLからリポジトリ名を抽出
selected_repo=$(echo $repo_url | sed -e 's/.*://' -e 's/\.git$//')

# リポジトリ名の抽出失敗した場合
if [ -z "$selected_repo" ] || [ "$select_repo_flg" = true ]; then
    # GitHubのリポジトリ一覧を取得し、fzfで選択させる
    selected_repo=$(gh repo list ${gh_user} --limit ${Limit1} |
    fzf --no-sort --reverse --prompt='select REPOSITORY: ' --no-multi)
fi

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name=$(echo "$selected_repo" | awk '{print $1}')

cmd="gh pr list $Type --repo $repo_name --limit $Limit2"

# pr/issue 番号取得
num=$(gh pr view --json number -q .number 2>/dev/null)

if [ -z "$num" ]; then
    echo "Error: Could not get PR number. Are you on a PR branch?"
    exit 1
fi

# CIステータス出力
if [ "$error_only_flg" = true ]; then
    # エラーのログのみを表示
    echo "=== Failed CI logs for PR #$num ==="
    echo ""
    
    # PRのヘッドブランチとSHAを取得
    pr_info=$(gh pr view "$num" --repo "$repo_name" --json headRefName,headRefOid -q '@json')
    head_branch=$(echo "$pr_info" | jq -r '.headRefName')
    head_sha=$(echo "$pr_info" | jq -r '.headRefOid')
    
    if [ -z "$head_branch" ] || [ "$head_branch" = "null" ]; then
        echo "Error: Could not get PR branch name"
        exit 1
    fi
    
    echo "Branch: $head_branch"
    echo "Commit: ${head_sha:0:7}"
    echo ""
    
    # 最新の失敗したワークフロー実行を1つだけ取得
    failed_run=$(gh run list --repo "$repo_name" --branch "$head_branch" --status failure --limit 1 \
        --json databaseId,conclusion,workflowName,createdAt,headSha,event \
        --jq '.[] | select(.headSha == "'"$head_sha"'") | "\(.databaseId)\t\(.workflowName)\t\(.createdAt)\t\(.event)"' | head -n 1)
    
    # 見つからない場合は、ブランチ全体から最新の失敗を探す
    if [ -z "$failed_run" ]; then
        failed_run=$(gh run list --repo "$repo_name" --branch "$head_branch" --status failure --limit 1 \
            --json databaseId,conclusion,workflowName,createdAt,headSha,event \
            --jq '.[] | "\(.databaseId)\t\(.workflowName)\t\(.createdAt)\t\(.event)"' | head -n 1)
    fi
    
    if [ -z "$failed_run" ]; then
        echo "❌ No failed runs found for this PR."
        echo ""
        echo "=== CI Status ==="
        gh pr checks "$num" --repo "$repo_name"
    else
        IFS=$'\t' read -r run_id workflow_name created_at event <<< "$failed_run"
        
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📛 Workflow: $workflow_name"
        echo "🔍 Run ID: $run_id"
        echo "📅 Created: $created_at"
        echo "⚡ Event: $event"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        
        # 失敗したステップのログのみを取得し、エラー部分を抽出
        gh run view "$run_id" --repo "$repo_name" --log-failed | \
            grep -E "^[^ ]|These files|not.*formatted|Run:|exit code|##\[error\]|Error:|error:|failed|Failed|FAILED" || \
            gh run view "$run_id" --repo "$repo_name" --log-failed
        
        echo ""
    fi
else
    # 通常のCIステータス出力
    gh pr checks "$num" --repo "$repo_name"
fi

