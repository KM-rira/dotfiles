#!/usr/bin/env bash

set -euo pipefail

AI_RULE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="${HOME:?HOME must be set}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

install_file() {
    local source="$1"
    local target="$2"
    mkdir -p "$(dirname -- "$target")"
    if [[ -e "$target" ]] && ! cmp -s "$source" "$target"; then
        local backup="${target}.backup.${TIMESTAMP}"
        cp -p "$target" "$backup"
        printf 'Backup: %s\n' "$backup"
    fi
    if [[ ! -e "$target" ]] || ! cmp -s "$source" "$target"; then
        cp "$source" "$target"
        printf 'Installed: %s\n' "$target"
    else
        printf 'Unchanged: %s\n' "$target"
    fi
}

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cp "$AI_RULE_DIR/USER_RULE.md" "$tmp_dir/CLAUDE.md"
cp "$AI_RULE_DIR/USER_RULE.md" "$tmp_dir/AGENTS.md"
{
    cat <<'EOF'
---
description: Global personal rules for AI coding assistance
alwaysApply: true
---

EOF
    cat "$AI_RULE_DIR/USER_RULE.md"
} > "$tmp_dir/ai-rule.mdc"

printf '%s\n' 'Installing personal AI rules and skills...'

install_file "$tmp_dir/CLAUDE.md" "$TARGET_HOME/.claude/CLAUDE.md"
install_file "$tmp_dir/AGENTS.md" "$TARGET_HOME/AGENTS.md"
install_file "$tmp_dir/ai-rule.mdc" "$TARGET_HOME/.cursor/rules/ai-rule.mdc"

for skill_file in "$AI_RULE_DIR"/skills/*/SKILL.md; do
    [[ -f "$skill_file" ]] || continue
    relative_path="${skill_file#"$AI_RULE_DIR/skills/"}"
    install_file "$skill_file" "$TARGET_HOME/.claude/skills/$relative_path"
    install_file "$skill_file" "$TARGET_HOME/.agents/skills/$relative_path"
done

printf '%s\n' 'Setup complete.'
