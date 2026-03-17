#!/usr/bin/env bash

set -e

# ===== 引数 =====
REPO_NAME=$1
VISIBILITY=${2:-public} # ← デフォルト public

if [ -z "$REPO_NAME" ]; then
  echo "Usage: $0 <repo-name> [public|private]"
  exit 1
fi

if [[ "$VISIBILITY" != "public" && "$VISIBILITY" != "private" ]]; then
  echo "Visibility must be 'public' or 'private'"
  exit 1
fi

echo "🚀 Creating repository: $REPO_NAME ($VISIBILITY)"

# ===== ディレクトリ作成 =====
mkdir -p "$REPO_NAME"
cd "$REPO_NAME"

# ===== Git初期化 =====
git init

# ===== 初期ファイル =====
echo "# $REPO_NAME" > README.md

cat <<EOF > .gitignore
# macOS
.DS_Store

# Node
node_modules
dist
.env

# Go
bin/
*.exe
*.test

# Editor
.vscode/
.idea/
EOF

# ===== commit =====
git add .
git commit -m "initial commit"

# ===== GitHub repo作成 & push =====
if command -v gh >/dev/null 2>&1; then
  echo "🔗 Using GitHub CLI"
  gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push
else
  echo "❌ gh CLI not found. Install: https://cli.github.com/"
  exit 1
fi

# ===== URL表示 =====
USER_NAME=$(gh api user --jq .login)
echo "✅ Done! https://github.com/$USER_NAME/$REPO_NAME"
