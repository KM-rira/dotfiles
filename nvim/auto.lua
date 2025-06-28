vim.api.nvim_create_augroup("source_vimrc", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "source_vimrc",
	pattern = "*vimrc",
	command = "source $MYVIMRC | set foldmethod=marker",
})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "source_vimrc",
	pattern = "*gvimrc",
	command = "if has('gui_running') | source $MYGVIMRC | endif",
})
vim.api.nvim_create_augroup("auto_comment_off", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = "auto_comment_off",
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
	end,
})
vim.api.nvim_create_augroup("MyXML", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "MyXML",
	pattern = "xml",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "i", "</", "</<C-x><C-o>", { noremap = true, silent = true })
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = "MyXML",
	pattern = "html",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "i", "</", "</<C-x><C-o>", { noremap = true, silent = true })
	end,
})
vim.api.nvim_create_augroup("QuickFixMapping", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "QuickFixMapping",
	pattern = "qf",
	callback = function()
		-- quickfix ウィンドウでは Enter をそのまま送る
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>", { noremap = true, silent = true })
		-- quickfix ウィンドウで Esc キーを押したらウィンドウを閉じる
		vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":cclose<CR>", { noremap = true, silent = true })
		-- quickfix ウィンドウでは j と k をデフォルトの動作にする
		vim.api.nvim_buf_set_keymap(0, "n", "j", "j", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "k", "k", { noremap = true, silent = true })
	end,
})
vim.cmd([[
  autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
]])
