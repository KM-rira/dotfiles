-- リーダーキーの設定
vim.g.mapleader = ';'

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>', {})

-- coc系
vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>(coc-definition)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>d', '<Plug>(coc-definition)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>d', '<Plug>(coc-definition)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>t', '<Plug>(coc-type-definition)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>t', '<Plug>(coc-type-definition)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>t', '<Plug>(coc-type-definition)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>c', '<Plug>(coc-declaration)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>c', '<Plug>(coc-declaration)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>c', '<Plug>(coc-declaration)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>i', '<Plug>(coc-implementation)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>i', '<Plug>(coc-implementation)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>i', '<Plug>(coc-implementation)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(coc-references)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>r', '<Plug>(coc-references)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>r', '<Plug>(coc-references)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>re', '<Plug>(coc-rename)', {silent = true})
vim.api.nvim_set_keymap('o', '<leader>re', '<Plug>(coc-rename)', {silent = true})
vim.api.nvim_set_keymap('x', '<leader>re', '<Plug>(coc-rename)', {silent = true})

vim.api.nvim_set_keymap('n', '<leader>h', ':call CocAction(\'doHover\')<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('o', '<leader>h', ':call CocAction(\'doHover\')<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('x', '<leader>h', ':call CocAction(\'doHover\')<CR>', {silent = true, noremap = true})

-- telescope系
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fcl', builtin.commands, {})
vim.keymap.set('n', '<leader>fch', builtin.command_history, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fs', builtin.search_history, {})
vim.keymap.set("n", "<leader>fz", "<Cmd>Telescope frecency<CR>")

-- 翻訳
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(Translate)', {silent = true})
vim.api.nvim_set_keymap('v', 't', '<Plug>(VTranslate)', {silent = true})

-- タブ関連
vim.api.nvim_set_keymap('n', 'tn', '<cmd>tabnew<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('o', 'tn', '<cmd>tabnew<cr>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('x', 'tn', '<cmd>tabnew<cr>', {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', {silent = true, noremap = true})

-- 矩形選択
vim.api.nvim_set_keymap('n', '<Leader>v', '<C-v>', {noremap = true})
vim.api.nvim_set_keymap('x', '<Leader>v', '<C-v>', {noremap = true})
vim.api.nvim_set_keymap('o', '<Leader>v', '<C-v>', {noremap = true})

-- 全選択
vim.api.nvim_set_keymap('n', 'vv', 'G$Vgg0', {noremap = true})

-- ノーマルモードのキーマッピング
vim.api.nvim_set_keymap('n', 'dx', 'dd', {noremap = true})
vim.api.nvim_set_keymap('n', 'dd', '"_dd', {noremap = true})
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('n', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('n', 'D', '"_D', {noremap = true})
vim.api.nvim_set_keymap('n', 'C', '"_C', {noremap = true})
vim.api.nvim_set_keymap('n', 'S', '"_S', {noremap = true})
vim.api.nvim_set_keymap('n', 's', '"_s', {noremap = true})
vim.api.nvim_set_keymap('n', 'm', '^', {noremap = true})
vim.api.nvim_set_keymap('n', '^', '+', {noremap = true})

-- ビジュアルモードのキーマッピング
vim.api.nvim_set_keymap('x', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('x', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('x', 'D', '"_D', {noremap = true})
vim.api.nvim_set_keymap('x', 'C', '"_C', {noremap = true})
vim.api.nvim_set_keymap('x', 'S', '"_S', {noremap = true})
vim.api.nvim_set_keymap('x', 's', '"_s', {noremap = true})
vim.api.nvim_set_keymap('x', 'm', '^', {noremap = true})
vim.api.nvim_set_keymap('x', '^', '+', {noremap = true})

-- オペレータモードのキーマッピング
vim.api.nvim_set_keymap('o', 'd', '"_d', {noremap = true})
vim.api.nvim_set_keymap('o', 'c', '"_c', {noremap = true})
vim.api.nvim_set_keymap('o', 'D', '"_D', {noremap = true})
vim.api.nvim_set_keymap('o', 'C', '"_C', {noremap = true})
vim.api.nvim_set_keymap('o', 'S', '"_S', {noremap = true})
vim.api.nvim_set_keymap('o', 's', '"_s', {noremap = true})
vim.api.nvim_set_keymap('o', 'm', '^', {noremap = true})
vim.api.nvim_set_keymap('o', '^', '+', {noremap = true})

-- ノーマル、ビジュアル、オペレータモードでのキーマッピング
vim.api.nvim_set_keymap('n', 'o', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', 'o', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', 'o', 'o<Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', 'O', 'O<Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', 'O', 'O<Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', 'O', 'O<Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', '(', 'i<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', '(', 'i<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', '(', 'i<Space><Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', ')', 'a<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('x', ')', 'a<Space><Esc>', {noremap = true})
vim.api.nvim_set_keymap('o', ')', 'a<Space><Esc>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Space>', '$', {noremap = true})
vim.api.nvim_set_keymap('x', '<Space>', '$', {noremap = true})
vim.api.nvim_set_keymap('o', '<Space>', '$', {noremap = true})

vim.api.nvim_set_keymap('n', 'J', '10j', {noremap = true})
vim.api.nvim_set_keymap('x', 'J', '10j', {noremap = true})
vim.api.nvim_set_keymap('o', 'J', '10j', {noremap = true})

vim.api.nvim_set_keymap('n', 'K', '10k', {noremap = true})
vim.api.nvim_set_keymap('x', 'K', '10k', {noremap = true})
vim.api.nvim_set_keymap('o', 'K', '10k', {noremap = true})

-- todo系
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
end, { desc = "Next error/warning todo comment" })
