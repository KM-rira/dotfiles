if vim.g.vscode then
	-- VS Code用の設定
	-- vim.cmd('source /path/to/vscode-specific-config.lua')
	require("vscode_nvim")
else
	-- 通常のNeovim用の設定
	require("plug")
	require("lsp")
	require("null_ls")
	require("auto")
	require("command")
	require("func")
	require("keymap")
	require("setting")
	require("view")
end
