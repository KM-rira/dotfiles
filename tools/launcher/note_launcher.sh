#!/bin/zsh

# ワイルドカードを含むパスを定義
TARGET_PATH="$vc/tools/note/*.sh"

# ~(N) を使用してファイルが存在しない場合に空の配列を返すようにする
files=(${~TARGET_PATH}(N))

# ファイルが見つからない場合のエラーチェック
if (( ${#files} == 0 )); then
    echo "No matching files found: $TARGET_PATH"
    return 1  # source で実行された場合は exit ではなく return を使用
fi

# 各ファイルを source する
for file in $files; do
    source "$file"
done
