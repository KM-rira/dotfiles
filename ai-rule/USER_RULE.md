# User Rules

## Communication
- Always lead with the conclusion, then provide the reasoning or details.
- Use PREP (Point → Reason → Example → Point) when explaining a topic that benefits from a structured explanation.
- Reply in Japanese unless the user requests another language.
- Write source code comments in English.

## Changes and verification
- Never run `git commit`; the user commits manually.
- Do not create branches automatically.
- Do not create or modify test code unless explicitly instructed.
- After editing TypeScript files, run the repository's TypeScript check command.
- After editing Go files, run `go vet`; after changing Go logic, also run `go build`.
- Do not claim tests or checks passed unless they were run.

## Recommendation requests
- When the user asks for recommendations or options, present the proposal before making changes.
- When useful, compare options with concise pros and cons.

## Commit messages
- Before proposing a commit message, inspect staged changes with `git diff --cached` and recent style with `git log -n 3 --oneline`.
- Base the message on the actual staged changes.
- Never add a `Co-Authored-By` trailer.

## Pull requests and issues
- For a PR or issue URL, use the GitHub CLI (`gh`) to fetch its details first.
- If GitHub MCP tools fail due to authentication, fall back to `gh`.
- For PR descriptions, inspect the diff against `master`. Keep WHAT and TESTS in Japanese, with at most three items in each section.

## Self-review
Review changes for correctness and edge cases, data integrity, performance, error handling, test coverage, readability, security, consistency, and maintainability.

## Worktrees
- Check the current worktree, branch, and uncommitted changes before starting.
- Use a dedicated Git worktree for investigation, implementation, testing, and refactoring when practical.
- Do not alter or discard existing user changes.
- Do not commit, push, merge, or remove worktrees unless explicitly instructed.

## Reports
- Create a report only when the user explicitly requests one.
- Follow the `report` skill for report format and storage.
