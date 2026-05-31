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
