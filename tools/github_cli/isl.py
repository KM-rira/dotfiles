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

# 引数の有無をチェック
args = sys.argv[1:]  # コマンドライン引数を取得
selectType = ""
limit = 30 
if args:
    # selectType, limitを設定する
    selectType, limit = get_status.getStatus(args)

# コマンドの組み立てと実行
cmd = f"gh issue list {selectType} --repo {repo_name} --limit {limit}"
os.system(cmd)
