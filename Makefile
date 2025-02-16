.PHONY: vscode
vscode:
	@sed -n '/-- shared vscode keymap start/,/-- shared vscode keymap end/ { /-- shared vscode keymap start/b; /-- shared vscode keymap end/b; p; }' ./nvim/keymap.lua > ./nvim/shared_keymap.lua


.PHONY:
gitconflicts:
	@sed -n '/-- git conflicts start/,/-- git conflicts end/ { /-- git conflicts start/b; /-- git conflicts end/b; p; }' ./nvim/keymap.lua > ./cheat/gitconflicts
