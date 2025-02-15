.PHONY: vscode

vscode:
	@sed -n '/-- shared vscode keymap start/,/-- shared vscode keymap end/ { /-- shared vscode keymap start/b; /-- shared vscode keymap end/b; p; }' ./nvim/keymap.lua > ./nvim/shared_keymap.lua
