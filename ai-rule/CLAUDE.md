# Personal Rules

## General
- Always lead with the conclusion first, then provide reasoning or details
- Use PREP format (Point -> Reason -> Example -> Point) for explanations
- Always reply in Japanese
- Write source code comments in English
- Never run git commit commands (user commits manually)
- Please do not create branches automatically. Users will create them by themselves.
- Do not implement or modify test code until explicitly instructed

## Commit Message
- When asked to create a commit message, always check the currently staged files first via git diff --cached
- Propose a concise commit message based on the actual staged changes
- Never add Co-Authored-By trailer to commit messages

## Recommendation Mode
- Do not create, delete, or edit files immediately
- Propose solutions first (e.g., "How about this approach?")
- If multiple approaches exist, list pros and cons for each

## Edit Rule
- After editing .ts files: run ts check command
- After editing .go files: run go vet

## Go Check Rule
- After modifying Go tests: run go test command
- After modifying Go logic only: run govet, go build

## PR Description
Use the format below. Keep it concise. WHAT and TESTS in Japanese. Max 3 items each.
Check diff between master and current branch via git diff.

## Self Review
Check implemented code against these criteria:
1. Functional requirements (correctness, edge cases)
2. Data integrity (transactions, rollback, concurrency)
3. Performance (N+1, unnecessary queries, memory leaks)
4. Error handling (messages, propagation with %w, logging)
5. Testing (main path, edge cases, error cases)
6. Readability (variable names, SRP, no magic numbers)
7. Security (SQL injection, auth, no secrets in logs)
8. Consistency (coding conventions, naming, architecture)
9. Maintainability (flexibility, dependencies, debuggability)

## Investigation Flow
- When given a PR or issue URL, always fetch information via gh CLI first
- If MCP GitHub tools fail with authentication errors, fall back to gh CLI

# Development Rules

## Git Worktree

- 調査・実装・テスト・リファクタリングは、原則として専用の Git worktree で行う。
- 並列で動くエージェントには、それぞれ独立した worktree とブランチを割り当てる。
- 作業開始前に、現在の worktree・ブランチ・未コミット変更を確認する。
- 既存の変更や他のエージェントの作業を、許可なく変更・破棄しない。
- worktree の作成前に既存の構成を確認し、重複を避ける。
- 明示的な指示がない限り、コミット・プッシュ・マージ・worktree の削除は行わない。
- 作業完了時は、変更内容とテスト結果を報告する。

## Commit Messages

- コミットメッセージを作成する際は、`git log -n 3 --oneline` で直近3件のコミットメッセージを確認し、リポジトリの命名規則や文体に合わせる。
