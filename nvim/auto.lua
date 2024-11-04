vim.api.nvim_create_augroup("source_vimrc", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "source_vimrc",
  pattern = "*vimrc",
  command = "source $MYVIMRC | set foldmethod=marker"
})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "source_vimrc",
  pattern = "*gvimrc",
  command = "if has('gui_running') | source $MYGVIMRC | endif"
})
vim.api.nvim_create_augroup("auto_comment_off", {clear = true})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "auto_comment_off",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end
})
vim.api.nvim_create_augroup("MyXML", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = "MyXML",
  pattern = "xml",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'i', '</', '</<C-x><C-o>', {noremap = true, silent = true})
  end
})
vim.api.nvim_create_autocmd("FileType", {
  group = "MyXML",
  pattern = "html",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'i', '</', '</<C-x><C-o>', {noremap = true, silent = true})
  end
})

