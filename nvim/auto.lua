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

-- 自動コマンドグループを作成（再定義を防ぐため）
vim.api.nvim_create_augroup("PhpFormatOnSave", { clear = true })

-- BufWritePost イベントに対する自動コマンドを作成
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.php",
  group = "PhpFormatOnSave",
  callback = function()
    local filepath = vim.fn.expand("%:p")  -- 現在のファイルの絶対パスを取得
    -- php-cs-fixer を実行
    local result = vim.fn.system("php-cs-fixer fix " .. vim.fn.shellescape(filepath))

    if vim.v.shell_error == 0 then
      -- フォーマットが成功した場合、ファイルを再読み込み
      vim.cmd("edit!")
      vim.notify("php-cs-fixer: ファイルをフォーマットしました。", vim.log.levels.INFO)
    else
      -- エラーが発生した場合、エラーメッセージを表示
      vim.notify("php-cs-fixer エラー:\n" .. result, vim.log.levels.ERROR)
    end
  end,
})
