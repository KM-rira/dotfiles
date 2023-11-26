import subprocess
import sys
import get_status
import os

def run_command(command):
    result = subprocess.run(command, shell=True, text=True, capture_output=True)
    return result.stdout.strip()

# GitHubのリポジトリ一覧を取得し、fzfで選択させる
gh_user = os.environ.get('gh_user', 'not export gh_user')
selected_repo = run_command(f"gh repo list {gh_user} | fzf")

# 選択されたリポジトリからリポジトリ名を抜き取る
repo_name = selected_repo.split()[0]

# コマンドの組み立てと実行
cmd = f"gh issue status --repo {repo_name}"
os.system(cmd)
