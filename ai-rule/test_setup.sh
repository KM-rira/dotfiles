#!/usr/bin/env bash

set -euo pipefail

AI_RULE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SETUP_SCRIPT="$AI_RULE_DIR/setup.sh"
TEST_HOME="$(mktemp -d)"
trap 'rm -rf "$TEST_HOME"' EXIT

fail() {
    printf 'FAIL: %s\n' "$1" >&2
    exit 1
}

assert_file_equals() {
    local expected="$1"
    local actual="$2"
    [[ -f "$actual" ]] || fail "Expected file does not exist: $actual"
    cmp -s "$expected" "$actual" || fail "File content differs: $actual"
}

assert_contains() {
    local needle="$1"
    local file="$2"
    grep -Fq -- "$needle" "$file" || fail "Expected '$needle' in $file"
}

run_setup() {
    HOME="$TEST_HOME" bash "$SETUP_SCRIPT" >/dev/null
}

printf '%s\n' 'Test: installs rules for all supported tools'
run_setup

assert_file_equals "$AI_RULE_DIR/USER_RULE.md" "$TEST_HOME/.claude/CLAUDE.md"
assert_file_equals "$AI_RULE_DIR/USER_RULE.md" "$TEST_HOME/AGENTS.md"
cursor_rule="$TEST_HOME/.cursor/rules/ai-rule.mdc"
expected_cursor_rule="$TEST_HOME/expected-cursor-rule.mdc"
{
    cat <<'EOF'
---
description: Global personal rules for AI coding assistance
alwaysApply: true
---

EOF
    cat "$AI_RULE_DIR/USER_RULE.md"
} > "$expected_cursor_rule"
assert_file_equals "$expected_cursor_rule" "$cursor_rule"

printf '%s\n' 'Test: installs every skill to Claude Code and shared agent skill directories'
skill_count=0
for source_skill in "$AI_RULE_DIR"/skills/*/SKILL.md; do
    [[ -f "$source_skill" ]] || continue
    relative_path="${source_skill#"$AI_RULE_DIR/skills/"}"
    assert_file_equals "$source_skill" "$TEST_HOME/.claude/skills/$relative_path"
    assert_file_equals "$source_skill" "$TEST_HOME/.agents/skills/$relative_path"
    skill_count=$((skill_count + 1))
done
(( skill_count > 0 )) || fail 'No skills found to install'

printf '%s\n' 'Test: rerunning setup is idempotent and does not create backups'
run_setup
backup_count="$(find "$TEST_HOME" -type f -name '*.backup.*' | wc -l | tr -d ' ')"
[[ "$backup_count" == 0 ]] || fail "Unexpected backups after an unchanged rerun: $backup_count"

printf '%s\n' 'Test: preserves and replaces a conflicting file'
conflict="$TEST_HOME/.claude/CLAUDE.md"
printf '%s\n' 'user-owned content' > "$conflict"
run_setup
backup_file=''
for candidate in "$TEST_HOME/.claude"/CLAUDE.md.backup.*; do
    if [[ -f "$candidate" ]]; then
        backup_file="$candidate"
        break
    fi
done
[[ -n "$backup_file" ]] || fail 'Expected a backup for the conflicting file'
[[ "$(cat "$backup_file")" == 'user-owned content' ]] || fail 'Backup does not preserve original content'
assert_file_equals "$AI_RULE_DIR/USER_RULE.md" "$conflict"

printf 'PASS: all AI rule setup checks passed (%d skills)\n' "$skill_count"
