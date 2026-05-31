#!/bin/bash
# set -e

# ヘルプ表示関数
show_help() {
    cat << EOF
使い方: $(basename "$0") [オプション]

複数のgo.modディレクトリに対するGoコード品質チェッカー

オプション:
    -d              git diffで変更があったディレクトリのみチェック
    -f              fzfで対話的にディレクトリを選択
    -t              変更された*_test.goファイル内のテスト関数のみテスト
    -m MODULE       指定モジュール名のディレクトリのみチェック（部分一致）
                   複数指定可: -m automation -m process
    -l              -mで指定可能なモジュール名一覧を表示して終了
    -h, --help      このヘルプメッセージを表示して終了

環境変数:
    \$check-target-dir-internal           (必須) go.modファイルを検索するベースディレクトリ
                   例: export check-target-dir-internal="/Users/koji.mitobe/project/coworking-agent/z"
    \$check-target-dir        (任意) 追加でgo.modを検索するディレクトリ（\$check-target-dir-internal配下と重複しないもののみ）
                   例: export check-target-dir="/Users/koji.mitobe/project/coworking-agent"

使用例:
    # 全てのgo.modディレクトリをチェック
    $(basename "$0")

    # 変更があったディレクトリのみチェック
    $(basename "$0") -d

    # fzfでディレクトリを選択
    $(basename "$0") -f

    # 変更されたテスト関数のみ実行
    $(basename "$0") -t

    # 指定モジュールのみチェック
    $(basename "$0") -m automation

    # 複数モジュールをチェック
    $(basename "$0") -m automation -m process

    # 利用可能なモジュール名一覧を表示
    $(basename "$0") -l

説明:
    このスクリプトは\$check-target-dir-internal配下の全てのgo.modディレクトリを自動検出し、
    各ディレクトリで以下のチェックを実行します:
    - gofmt (コードフォーマット)
    - go vet (静的解析)
    - go test (race detectorを使用したユニットテスト)
    - golangci-lint (リンター)
    - go build (ビルド検証)

    -tオプション使用時は、変更された*_test.goファイルを検出し、
    変更行を含むテスト関数のみを実行します。

EOF
    exit 0
}

# オプション解析（--helpのチェック）
for arg in "$@"; do
    if [ "$arg" = "--help" ]; then
        show_help
    fi
done

# オプション解析
DIFF_MODE=false
FZF_MODE=false
TEST_MODE=false
LIST_MODE=false
MODULE_NAMES=()
while getopts "dftlm:h" opt; do
    case $opt in
        d)
            DIFF_MODE=true
            ;;
        f)
            FZF_MODE=true
            ;;
        t)
            TEST_MODE=true
            ;;
        l)
            LIST_MODE=true
            ;;
        m)
            MODULE_NAMES+=("$OPTARG")
            ;;
        h)
            show_help
            ;;
        *)
            echo "Usage: $(basename "$0") [-d] [-f] [-t] [-m MODULE] [-l] [-h|--help]"
            echo "Use -h or --help for more information."
            exit 1
            ;;
    esac
done

# $check-target-dir-internal環境変数のチェック（必須）
if [ -z "$check-target-dir-internal" ]; then
    echo "🚨 ERROR: \$check-target-dir-internal environment variable is not set."
    echo "Please set \$check-target-dir-internal to your project root directory."
    echo "Example: export check-target-dir-internal=\"/Users/koji.mitobe/project/core/z\""
    exit 1
fi

# 重複チェック用の関数（bash 3.x互換）
array_contains() {
    local element="$1"
    shift
    local arr=("$@")
    for item in "${arr[@]}"; do
        if [ "$item" = "$element" ]; then
            return 0
        fi
    done
    return 1
}

# 1. 全てのgo.modディレクトリを取得
echo "🔍 Searching for go.mod files in \$check-target-dir-internal..."
echo "📂 Search base directory: $check-target-dir-internal"

ALL_GO_MOD_DIRS=()
while IFS= read -r dir_path; do
    ALL_GO_MOD_DIRS+=("$dir_path")
done < <(cd "$check-target-dir-internal" && fd -t f -a '^go\.mod$' -x dirname)

# $check-target-dir配下のgo.modも収集（$check-target-dir-internal配下と重複しないもののみ）
if [ -n "$check-target-dir" ] && [ -d "$check-target-dir" ]; then
    while IFS= read -r dir_path; do
        if [[ "$dir_path" == "$check-target-dir-internal"* ]]; then
            continue
        fi
        if ! array_contains "$dir_path" "${ALL_GO_MOD_DIRS[@]}"; then
            ALL_GO_MOD_DIRS+=("$dir_path")
        fi
    done < <(cd "$check-target-dir" && fd -t f -a '^go\.mod$' -x dirname)
fi

# -t オプション時はリポジトリルートからも go.mod を探す（$check-target-dir-internal 外の変更に対応）
if [ "$TEST_MODE" = true ]; then
    GIT_ROOT=$(cd "$check-target-dir-internal" && git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$GIT_ROOT" ] && [ "$GIT_ROOT" != "$check-target-dir-internal" ]; then
        while IFS= read -r dir_path; do
            if ! array_contains "$dir_path" "${ALL_GO_MOD_DIRS[@]}"; then
                ALL_GO_MOD_DIRS+=("$dir_path")
            fi
        done < <(cd "$GIT_ROOT" && fd -t f -a '^go\.mod$' -x dirname)
    fi
fi

# モジュール名を抽出する関数（パスの末尾ディレクトリ名）
get_module_name() {
    basename "$1"
}

# -l: モジュール名一覧を表示して終了
if [ "$LIST_MODE" = true ]; then
    echo "📦 Available modules (-m option):"
    echo ""
    for dir in "${ALL_GO_MOD_DIRS[@]}"; do
        mod_name=$(get_module_name "$dir")
        # $check-target-dir-internal からの相対パスを表示
        rel_path="${dir#"$check-target-dir-internal"/}"
        if [ "$rel_path" = "$dir" ]; then
            # $check-target-dir-internal 外のパス（$check-target-dir等）はフルパスの末尾部分を表示
            GIT_ROOT=$(cd "$check-target-dir-internal" && git rev-parse --show-toplevel 2>/dev/null)
            if [ -n "$GIT_ROOT" ]; then
                rel_path="${dir#"$GIT_ROOT"/}"
            fi
        fi
        printf "  %-30s %s\n" "$mod_name" "$rel_path"
    done
    exit 0
fi

if [ ${#ALL_GO_MOD_DIRS[@]} -eq 0 ]; then
    echo "⚠️ No go.mod found in \$check-target-dir-internal."
    exit 1
fi

# テスト出力をフィルタリングして、FAIL とエラー情報のみを表示
filter_test_output() {
    local output_file="$1"
    local show_line=0

    while IFS= read -r line; do
        # FAIL を含む行を表示
        if [[ "$line" =~ ^---\ FAIL: ]] || [[ "$line" =~ ^FAIL[[:space:]] ]]; then
            echo "$line"
            show_line=1
        # PASS の行はスキップ
        elif [[ "$line" =~ ^---\ PASS: ]]; then
            show_line=0
            continue
        # panic やエラーメッセージを表示
        elif [[ "$line" =~ panic:|recovered|repanicked|SIGSEGV|segmentation\ violation|goroutine|runtime\ error ]]; then
            echo "$line"
            show_line=1
        # スタックトレース（.go:行番号 のパターン）を表示
        elif [[ "$line" =~ \.go:[0-9]+ ]]; then
            echo "$line"
        # [signal や created by などのランタイム情報を表示
        elif [[ "$line" =~ ^\[signal|^created\ by ]]; then
            echo "$line"
        # 表示コンテキスト中の行を表示（インデントされた行など）
        elif [ $show_line -eq 1 ]; then
            # INFO や WARN ログは除外
            if [[ "$line" =~ ^[0-9]{4}/[0-9]{2}/[0-9]{2}.*INFO|^[0-9]{4}/[0-9]{2}/[0-9]{2}.*WARN ]]; then
                continue
            fi
            echo "$line"
        fi
    done < "$output_file"
}

# テスト関数を検出する関数
# 引数: ファイルパス, 行番号
# 出力: テスト関数名（見つからない場合は空）
# 変更行を含むテスト関数を特定する。変更行がテスト関数の外（import文等）の場合、
# diff hunkの範囲内にあるテスト関数を検出するため、変更行以降も走査する。
find_test_function() {
    local file="$1"
    local line_num="$2"
    local current_test=""
    local current_line=0
    local found_at_line=""
    local found_after=""

    while IFS= read -r line_content; do
        current_line=$((current_line + 1))

        # Test関数の開始を検出（func TestXxx または func (s *Suite) TestXxx）
        if [[ "$line_content" =~ ^func[[:space:]]+(.*[[:space:]])?Test([A-Z][a-zA-Z0-9_]*) ]]; then
            current_test="Test${BASH_REMATCH[2]}"

            # 変更行以降で見つかったテスト関数 = 新しく追加されたテスト関数の可能性
            if [ $current_line -ge "$line_num" ] && [ -z "$found_at_line" ] && [ -z "$found_after" ]; then
                found_after="$current_test"
            fi
        fi

        # 指定された行番号に到達した時点のテスト関数を記録
        if [ $current_line -eq "$line_num" ] && [ -n "$current_test" ]; then
            found_at_line="$current_test"
        fi

        # 変更行の20行先まで走査（新規テスト関数の検出用）
        if [ $current_line -gt $((line_num + 20)) ]; then
            break
        fi
    done < "$file"

    # 変更行がテスト関数内にあればそれを返す
    if [ -n "$found_at_line" ]; then
        echo "$found_at_line"
        return 0
    fi

    # 変更行の近くに新しいテスト関数があればそれを返す
    if [ -n "$found_after" ]; then
        echo "$found_after"
        return 0
    fi

    return 1
}

# 2. -tオプションが指定された場合は差分のあるテスト関数のみを実行
if [ "$TEST_MODE" = true ]; then
    echo "🔍 Checking git diff to find changed test files..."

    cd "$check-target-dir-internal"

    # git diff で変更された *_test.go ファイルと行番号を取得
    # フォーマット: ファイル名:行番号
    # hunk の開始行と行数を両方取得し、範囲内の全行を出力する
    CHANGED_TEST_INFO=$(git --no-pager diff --no-color --unified=0 HEAD | awk '
        /^\+\+\+ b\// {
            file = substr($0, 7);
            if (file ~ /_test\.go$/) {
                test_file = file;
            } else {
                test_file = "";
            }
        }
        /^@@/ {
            if (test_file != "") {
                # @@ -1,2 +3,4 @@ の形式から +3,4 の部分を抽出
                line_part = $3;
                # + を削除
                sub(/^\+/, "", line_part);
                # 開始行と行数を分離
                split(line_part, parts, ",");
                start = parts[1];
                # 行数が省略されている場合は1行
                count = (length(parts) > 1) ? parts[2] : 1;
                if (start != "" && count > 0) {
                    for (i = 0; i < count; i++) {
                        print test_file ":" (start + i);
                    }
                }
            }
        }
    ')

    if [ -z "$CHANGED_TEST_INFO" ]; then
        echo "⚠️ No changes detected in *_test.go files."
        exit 0
    fi

    echo "📝 Changed test files and lines detected:"
    echo "$CHANGED_TEST_INFO"
    echo ""

    # 変更されたテストファイルごとに、テスト関数を特定
    declare -A DIR_TO_TESTS  # bash 3.x では使えないので別の方法を使う
    TARGET_DIRS=()
    TEST_PATTERNS=()

    GIT_ROOT=$(cd "$check-target-dir-internal" && git rev-parse --show-toplevel 2>/dev/null)

    while IFS=: read -r changed_file line_num; do
        [ -z "$changed_file" ] && continue

        # パスの正規化: git diff の出力はリポジトリルートからの相対パス
        # まず $check-target-dir-internal ベースで解決を試み、見つからなければ GIT_ROOT ベースで解決
        changed_file_abs=""
        check-target-dir-internal_basename=$(basename "$check-target-dir-internal")
        if [[ "$changed_file" == "$check-target-dir-internal_basename/"* ]]; then
            local_path="${changed_file#$check-target-dir-internal_basename/}"
            if [ -f "$check-target-dir-internal/$local_path" ]; then
                changed_file_abs="$check-target-dir-internal/$local_path"
            fi
        fi
        if [ -z "$changed_file_abs" ] && [ -n "$GIT_ROOT" ] && [ -f "$GIT_ROOT/$changed_file" ]; then
            changed_file_abs="$GIT_ROOT/$changed_file"
        fi

        # ファイルが存在するか確認
        if [ -z "$changed_file_abs" ] || [ ! -f "$changed_file_abs" ]; then
            continue
        fi

        # テスト関数を検出
        test_func=$(find_test_function "$changed_file_abs" "$line_num")

        if [ -n "$test_func" ]; then
            echo "🎯 Found test function: $test_func in $changed_file (line $line_num)"

            # このファイルが属するgo.modディレクトリを特定
            for go_mod_dir in "${ALL_GO_MOD_DIRS[@]}"; do
                if [[ "$go_mod_dir" != /* ]]; then
                    go_mod_dir_abs="$check-target-dir-internal/$go_mod_dir"
                else
                    go_mod_dir_abs="$go_mod_dir"
                fi

                if [[ "$changed_file_abs" == "$go_mod_dir_abs"* ]]; then
                    # ディレクトリとテストパターンを記録
                    if ! array_contains "$go_mod_dir_abs" "${TARGET_DIRS[@]}"; then
                        TARGET_DIRS+=("$go_mod_dir_abs")
                    fi

                    # テストパターンを追加（重複チェック）
                    test_pattern="$go_mod_dir_abs:$test_func"
                    if ! array_contains "$test_pattern" "${TEST_PATTERNS[@]}"; then
                        TEST_PATTERNS+=("$test_pattern")
                    fi
                    break
                fi
            done
        fi
    done <<< "$CHANGED_TEST_INFO"

    if [ ${#TARGET_DIRS[@]} -eq 0 ]; then
        echo "⚠️ No test functions found in changed test files."
        exit 0
    fi

    echo ""
    echo "✅ Found ${#TARGET_DIRS[@]} directories with test changes:"
    for dir in "${TARGET_DIRS[@]}"; do
        echo "   - $dir"
    done

# 3. -fオプションが指定された場合はfzfで選択
elif [ "$FZF_MODE" = true ]; then
    echo "🔍 Select directories with fzf (Tab to select multiple, Enter to confirm)..."

    # fzfが存在するかチェック
    if ! command -v fzf &> /dev/null; then
        echo "🚨 ERROR: fzf command not found. Please install fzf."
        echo "Install: brew install fzf"
        exit 1
    fi

    # fzfで複数選択可能にして、選択されたディレクトリを配列に格納
    TARGET_DIRS=()
    while IFS= read -r selected_dir; do
        TARGET_DIRS+=("$selected_dir")
    done < <(printf '%s\n' "${ALL_GO_MOD_DIRS[@]}" | fzf --multi --prompt="Select go.mod directories> ")

    if [ ${#TARGET_DIRS[@]} -eq 0 ]; then
        echo "⚠️ No directories selected."
        exit 0
    fi

    echo "✅ Selected ${#TARGET_DIRS[@]} directories:"
    for dir in "${TARGET_DIRS[@]}"; do
        echo "   - $dir"
    done

# 3. -mオプションが指定された場合はモジュール名でフィルタ
elif [ ${#MODULE_NAMES[@]} -gt 0 ]; then
    echo "🔍 Filtering by module name(s): ${MODULE_NAMES[*]}"
    TARGET_DIRS=()

    for dir in "${ALL_GO_MOD_DIRS[@]}"; do
        mod_name=$(get_module_name "$dir")
        for pattern in "${MODULE_NAMES[@]}"; do
            if [[ "$mod_name" == *"$pattern"* ]]; then
                if ! array_contains "$dir" "${TARGET_DIRS[@]}"; then
                    TARGET_DIRS+=("$dir")
                fi
                break
            fi
        done
    done

    if [ ${#TARGET_DIRS[@]} -eq 0 ]; then
        echo "⚠️ No modules matched: ${MODULE_NAMES[*]}"
        echo "Use -l to list available modules."
        exit 1
    fi

    echo "✅ Matched ${#TARGET_DIRS[@]} directories:"
    for dir in "${TARGET_DIRS[@]}"; do
        echo "   - $(get_module_name "$dir")  ($dir)"
    done

# 4. -dオプションが指定された場合は差分があるディレクトリのみをフィルタ
elif [ "$DIFF_MODE" = true ]; then
    echo "🔍 Checking git diff to find changed files..."

    cd "$check-target-dir-internal"

    # git diff でステージ済みと未ステージの差分ファイルを取得
    CHANGED_FILES=$(git --no-pager diff --name-only HEAD)

    if [ -z "$CHANGED_FILES" ]; then
        echo "⚠️ No changes detected in git diff."
        exit 0
    fi

    echo "📝 Changed files detected:"
    echo "$CHANGED_FILES"
    echo ""

    # 差分ファイルが属するgo.modディレクトリを特定
    TARGET_DIRS=()

    while IFS= read -r changed_file; do
        [ -z "$changed_file" ] && continue

        # git diff の出力に余計なプレフィックスが付いている場合があるので、正規化
        # 例: "z/go/app/..." -> "go/app/..."
        # $check-target-dir-internal のベース名（最後のディレクトリ名）を取得
        check-target-dir-internal_basename=$(basename "$check-target-dir-internal")

        # 変更ファイルのパスから余計なプレフィックスを削除
        if [[ "$changed_file" == "$check-target-dir-internal_basename/"* ]]; then
            changed_file="${changed_file#$check-target-dir-internal_basename/}"
        fi

        # 変更ファイルの絶対パスを取得
        changed_file_abs="$check-target-dir-internal/$changed_file"

        # 各go.modディレクトリについて、変更ファイルがそのディレクトリ配下かチェック
        for go_mod_dir in "${ALL_GO_MOD_DIRS[@]}"; do
            # go_mod_dirが相対パスの場合は絶対パスに変換
            if [[ "$go_mod_dir" != /* ]]; then
                go_mod_dir_abs="$check-target-dir-internal/$go_mod_dir"
            else
                go_mod_dir_abs="$go_mod_dir"
            fi

            # 変更ファイルがこのgo.modディレクトリ配下にあるかチェック
            if [[ "$changed_file_abs" == "$go_mod_dir_abs"* ]]; then
                # まだ追加していない場合のみ追加（bash 3.x互換の方法）
                if ! array_contains "$go_mod_dir_abs" "${TARGET_DIRS[@]}"; then
                    TARGET_DIRS+=("$go_mod_dir_abs")
                fi
                break
            fi
        done
    done <<< "$CHANGED_FILES"

    if [ ${#TARGET_DIRS[@]} -eq 0 ]; then
        echo "⚠️ No go.mod directories found for changed files."
        echo "Debug info:"
        echo "  Changed files: $CHANGED_FILES"
        echo "  All go.mod dirs count: ${#ALL_GO_MOD_DIRS[@]}"
        exit 0
    fi

    echo "✅ Found ${#TARGET_DIRS[@]} directories with changes:"
    for dir in "${TARGET_DIRS[@]}"; do
        echo "   - $dir"
    done
else
    # -dオプションなしの場合は全ディレクトリをチェック
    TARGET_DIRS=("${ALL_GO_MOD_DIRS[@]}")

    echo "✅ Found ${#TARGET_DIRS[@]} directories with go.mod:"
    for dir in "${TARGET_DIRS[@]}"; do
        echo "   - $dir"
    done
fi

echo "🚀 Go Code Checks Started"
echo "---"

# エラーカウンター
TOTAL_ERRORS=0
FAILED_DIRS=()

# メインのループ処理
for DIR in "${TARGET_DIRS[@]}"; do
    echo "📂 Processing directory: $DIR"

    if [ ! -d "$DIR" ]; then
        echo "🚨 ERROR: Directory '$DIR' not found. Skipping..."
        continue
    fi

    # -tオプションの場合は、このディレクトリに対応するテスト関数のみを実行
    if [ "$TEST_MODE" = true ]; then
        # このディレクトリに対応するテスト関数を取得
        DIR_TEST_FUNCS=()
        for pattern in "${TEST_PATTERNS[@]}"; do
            pattern_dir="${pattern%%:*}"
            pattern_func="${pattern##*:}"
            if [ "$pattern_dir" = "$DIR" ]; then
                DIR_TEST_FUNCS+=("$pattern_func")
            fi
        done

        if [ ${#DIR_TEST_FUNCS[@]} -eq 0 ]; then
            echo "⚠️ No test functions found for this directory. Skipping..."
            continue
        fi

        # テスト関数名を | で結合して正規表現パターンを作成
        TEST_RUN_PATTERN=$(IFS='|'; echo "${DIR_TEST_FUNCS[*]}")

        DIR_HAS_ERROR=0
        (
            cd "$DIR"
            echo "📍 Current Path: $(pwd)"
            echo "🎯 Test functions to run: ${DIR_TEST_FUNCS[*]}"

            ## テスト関数のみを実行
            echo "🔍 Running go test with pattern: $TEST_RUN_PATTERN"

            # 一時ファイルに出力をキャプチャ
            TEST_OUTPUT=$(mktemp)
            if go test -race -v -run "^($TEST_RUN_PATTERN)$" ./... > "$TEST_OUTPUT" 2>&1; then
                echo "✅ Tests passed"
                rm -f "$TEST_OUTPUT"
                exit 0
            else
                echo "❌ Tests failed. Relevant output:"
                filter_test_output "$TEST_OUTPUT"
                rm -f "$TEST_OUTPUT"
                exit 1
            fi
        )

        if [ $? -ne 0 ]; then
            TOTAL_ERRORS=$((TOTAL_ERRORS + 1))
            FAILED_DIRS+=("$DIR")
        fi
    else
        # 通常モード: 全てのチェックを実行
        DIR_HAS_ERROR=0
        (
            cd "$DIR"
            echo "📍 Current Path: $(pwd)"

            HAS_ERROR=0

            ## 1. go fmt
            echo "🔍 Running gofmt..."
            GOFMT_OUTPUT=$(gofmt -l -s -w .)
            if [ -n "$GOFMT_OUTPUT" ]; then
                echo "✅ gofmt: Formatted files:"
                echo "$GOFMT_OUTPUT"
            else
                echo "✅ gofmt: No formatting changes needed"
            fi

            ## 2. go vet
            echo "🔍 Running go vet..."
            VET_OUTPUT=$(mktemp)
            if go vet ./... > "$VET_OUTPUT" 2>&1; then
                echo "✅ go vet: No issues found"
            else
                echo "❌ go vet failed. Output:"
                cat "$VET_OUTPUT"
                HAS_ERROR=1
            fi
            rm -f "$VET_OUTPUT"

            ## 3. go test
            echo "🔍 Running go test..."
            TEST_OUTPUT=$(mktemp)
            if go test -race -v ./... > "$TEST_OUTPUT" 2>&1; then
                echo "✅ go test: All tests passed"
            else
                echo "❌ go test failed. Relevant output:"
                filter_test_output "$TEST_OUTPUT"
                HAS_ERROR=1
            fi
            rm -f "$TEST_OUTPUT"

            ## 4. golangci-lint
            echo "🔍 Running golangci-lint..."
            go mod tidy
            LINT_OUTPUT=$(mktemp)

            # 常に実行するが、結果はフィルタリングする
            # CI環境と一致させるため $check-target-dir-internal/go/tools/ci/.golangci.yml を使用する
            GOLANGCI_CONFIG="$check-target-dir-internal/go/tools/ci/.golangci.yml"
            golangci-lint run --config "$GOLANGCI_CONFIG" > "$LINT_OUTPUT" 2>&1 || true

            # git diff で変更されたファイルのリストを取得（$check-target-dir-internalから相対パス）
            cd "$check-target-dir-internal"
            CHANGED_FILES_LIST=$(git --no-pager diff --name-only HEAD | grep '\.go$' || true)
            cd "$DIR"

            if [ -n "$CHANGED_FILES_LIST" ]; then
                # 変更ファイルに関連するエラーのみを抽出
                FILTERED_LINT=$(mktemp)
                while IFS= read -r changed_file; do
                    # パスの正規化
                    check-target-dir-internal_basename=$(basename "$check-target-dir-internal")
                    if [[ "$changed_file" == "$check-target-dir-internal_basename/"* ]]; then
                        changed_file="${changed_file#$check-target-dir-internal_basename/}"
                    fi

                    # このディレクトリ配下の変更ファイルのみを対象
                    changed_file_abs="$check-target-dir-internal/$changed_file"
                    if [[ "$changed_file_abs" == "$DIR"* ]]; then
                        # 相対パスに変換
                        changed_file_rel="${changed_file_abs#$DIR/}"
                        # golangci-lint の出力から該当ファイルの行を抽出
                        grep "^${changed_file_rel}:" "$LINT_OUTPUT" >> "$FILTERED_LINT" 2>/dev/null || true
                    fi
                done <<< "$CHANGED_FILES_LIST"

                # フィルタ結果をチェック
                if [ -s "$FILTERED_LINT" ]; then
                    echo "❌ golangci-lint found issues in changed files:"
                    cat "$FILTERED_LINT"
                    HAS_ERROR=1
                else
                    echo "✅ golangci-lint: No issues in changed files"
                fi
                rm -f "$FILTERED_LINT"
            else
                # 変更ファイルがない場合は全てのエラーをチェック
                if [ -s "$LINT_OUTPUT" ]; then
                    echo "⚠️ golangci-lint found issues (no changed files to filter):"
                    cat "$LINT_OUTPUT"
                else
                    echo "✅ golangci-lint: No issues found"
                fi
            fi
            rm -f "$LINT_OUTPUT"

            echo "🔍 Running go build..."
            BUILD_OUTPUT=$(mktemp)
            if go build ./... > "$BUILD_OUTPUT" 2>&1; then
                echo "✅ go build: Build successful"
            else
                echo "❌ go build failed. Output:"
                cat "$BUILD_OUTPUT"
                HAS_ERROR=1
            fi
            rm -f "$BUILD_OUTPUT"

            if [ $HAS_ERROR -eq 0 ]; then
                echo "✅ All checks passed for $DIR"
            else
                echo "⚠️ Some checks failed for $DIR"
            fi

            exit $HAS_ERROR
        )

        if [ $? -ne 0 ]; then
            TOTAL_ERRORS=$((TOTAL_ERRORS + 1))
            FAILED_DIRS+=("$DIR")
        fi
    fi
    echo "---"
done

echo ""
echo "=========================================="
echo "📊 Summary"
echo "=========================================="
echo "Total directories checked: ${#TARGET_DIRS[@]}"
echo "Passed: $((${#TARGET_DIRS[@]} - TOTAL_ERRORS))"
echo "Failed: $TOTAL_ERRORS"

if [ $TOTAL_ERRORS -eq 0 ]; then
    echo ""
    echo "🎉 All checks passed!"
    exit 0
else
    echo ""
    echo "❌ Failed directories:"
    for failed_dir in "${FAILED_DIRS[@]}"; do
        echo "   - $failed_dir"
    done
    echo ""
    echo "⚠️ Some checks failed, but script completed."
    exit 0
fi
# #!/bin/bash
# set -e # エラーが発生した場合、スクリプトを即座に終了させる
#
# # 1. ターゲットディレクトリの決定ロジック (変更なしで保持)
# if [ -z "$WORK_DIR" ]; then
#     # WORK_DIRが未設定の場合、カレントディレクトリ以下の全てを対象とする
#     TARGET_DIR="./"
#     echo "⚠️ WORK_DIR not set. Defaulting check scope to: ${TARGET_DIR} (current directory)"
# else
#     # WORK_DIR が設定されている場合はその値を適用 (末尾の /... はここでは削除)
#     TARGET_DIR="$WORK_DIR"
# fi
#
# echo "🚀 Go Code Checks Started for ${TARGET_DIR}"
# echo "---"
#
# # 2. 💡 TARGET_DIR に移動
# if [ ! -d "$TARGET_DIR" ]; then
#     echo "🚨 ERROR: Directory '$TARGET_DIR' not found."
#     exit 1
# fi
#
# echo "Changing directory to: $TARGET_DIR"
# cd "$TARGET_DIR"
#
# # 3. 💡 全コマンドを シンプルな "./..." で実行
#
# # ターゲットを ./... に設定
# CHECK_SCOPE="./..."
#
# ## 1. go fmt (コードフォーマットの修正とチェック)
# echo "🔍 Running gofmt -w..."
# gofmt -l -s -w .
# echo "✅ go fmt passed. Files corrected."
#
# echo "---"
#
# ## 2. go vet (静的解析による疑わしいコードのチェック)
# echo "🔍 Running go vet..."
# go vet ./...
# echo "✅ go vet passed. No suspicious constructs found."
#
# echo "---"
#
# ## 4. go test (テストの実行)
# echo "🔍 Running go test..."
# go test -race -v ./...
# echo "✅ go test passed. All tests completed successfully."
#
# echo "---"
# echo "🎉 All checks completed successfully!"
#
# ## 3. golangci-lint (静的解析の実行)
# # NOTE: golangci-lint は事前にインストールが必要です。
# echo "🔍 Running golangci-lint..."
# go mod tidy
# golangci-lint run
# echo "✅ golangci-lint passed. No issues found."
#
# echo "---"
#
# cd -
