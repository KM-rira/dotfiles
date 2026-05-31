#!/bin/bash
# set -e # エラーが発生した場合、スクリプトを即座に終了させる

# 1. ターゲットディレクトリの決定ロジック
if [ -z "$TS_WORK_DIR" ]; then
    TARGET_DIR="./"
    echo "⚠️ TS_WORK_DIR not set. Defaulting check scope to: ${TARGET_DIR} (current directory)"
else
    TARGET_DIR="$TS_WORK_DIR"
fi

echo "🚀 TypeScript/Bun Code Checks Started for ${TARGET_DIR}"
echo "---"

# 2. TARGET_DIR に移動
if [ ! -d "$TARGET_DIR" ]; then
    echo "🚨 ERROR: Directory '$TARGET_DIR' not found."
    exit 1
fi

echo "Changing directory to: $TARGET_DIR"
cd "$TARGET_DIR"

# 3. 各種チェックの実行
echo "🔍 biome write start"
cd "$TARGET_DIR" && bun run check:write
echo "✅ biome write end"

echo "🔍 bun tsc start"
cd "$TARGET_DIR" && bun run tsc
echo "✅ bun tsc end"

echo "🔍 bun test start"
cd "$TARGET_DIR" && bun test
echo "✅ bun test end"

echo "---"
echo "🎉 All checks completed successfully!"

cd - >/dev/null

# "dev": "bun run --hot src/app.ts",
# "tsc": "tsc --pretty --noEmit",
# "check": "biome check",
# "check:write": "biome check --write"

# ## 1. bun format (go fmt に相当)
# echo "🔍 Running bun format..."
# # bun format はデフォルトでファイルを上書き保存します
# bun x prettier --write .
# echo "✅ bun format passed. Files formatted."
#
# echo "---"
#
# ## 2. tsc (go vet に相当: 型チェック)
# echo "🔍 Running Type Check (tsc)..."
# # コンパイルはせず、型エラーがないかのみを確認
# bun x tsc --noEmit
# echo "✅ Type check passed. No type errors found."
#
# echo "---"
#
# ## 3. bun test (go test に相当)
# echo "🔍 Running bun test..."
# # Bun内蔵の高速なテストランナーを実行
# bun test
# echo "✅ bun test passed. All tests completed successfully."
#
# echo "---"
#
# ## 4. eslint (golangci-lint に相当)
# echo "🔍 Running eslint..."
# # インストールされている依存関係を使用して実行
# bun x eslint .
# echo "✅ eslint passed. No linting issues found."
#
# echo "---"
# echo "🎉 All checks completed successfully!"
#
# cd - >/dev/null
