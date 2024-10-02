-- リーダーキーの設定
vim.g.mapleader = ';'

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>', {})

-- barbar系
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- バッファの移動
map('n', '<A->>', ':BufferLineMoveNext<CR>', opts)
map('n', '<A-<>', ':BufferLineMovePrev<CR>', opts)

-- 特定のバッファへの移動
map('n', '<leader>b1', ':BufferLineGoToBuffer 1<CR>', opts)
map('n', '<leader>b2', ':BufferLineGoToBuffer 2<CR>', opts)
map('n', '<leader>b3', ':BufferLineGoToBuffer 3<CR>', opts)
map('n', '<leader>b4', ':BufferLineGoToBuffer 4<CR>', opts)
map('n', '<leader>b5', ':BufferLineGoToBuffer 5<CR>', opts)
map('n', '<leader>b6', ':BufferLineGoToBuffer 6<CR>', opts)
map('n', '<leader>b7', ':BufferLineGoToBuffer 7<CR>', opts)
map('n', '<leader>b8', ':BufferLineGoToBuffer 8<CR>', opts)
map('n', '<leader>b9', ':BufferLineGoToBuffer 9<CR>', opts)

-- バッファの閉じるコマンド
map('n', '<leader>bo', ':BufferLineCloseOther<CR>', opts)
map('n', '<leader>bl', ':BufferLineCloseLeft<CR>', opts)
map('n', '<leader>br', ':BufferLineCloseRight<CR>', opts)
map('n', '<leader>bc', ':BufferLinePickClose<CR>', opts)
map('n', '<leader>bp', ':BufferLinePick<CR>', opts)

map('n', '<leader>be', ':BufferLineSortByExtension<CR>', opts)
map('n', '<leader>bd', ':BufferLineSortByRelativeDirectory<CR>', opts)

-- coc系
vim.keymap.set({'n', 'x', 'o'},'<leader>gd', '<Plug>(coc-definition)',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'},'<leader>gt', '<Plug>(coc-type-definition)',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'},'<leader>gc', '<Plug>(coc-declaration)',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'},'<leader>gi', '<Plug>(coc-implementation)',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'},'<leader>gr', '<Plug>(coc-references)',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'},'<leader>gn', '<Plug>(coc-rename)',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'},'<leader>gh', ':call CocAction(\'doHover\')<CR>',{ noremap = true, silent = true })

-- telescope系
local builtin = require('telescope.builtin')
vim.keymap.set({'n', 'x', 'o'}, '<leader>ff', builtin.find_files, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fg', builtin.live_grep, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fb', builtin.buffers, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fo', builtin.oldfiles, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fc', builtin.commands, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fh', builtin.command_history, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fj', builtin.jumplist, {})
vim.keymap.set({'n', 'x', 'o'}, '<leader>fs', builtin.search_history, {})
vim.keymap.set({'n', 'x', 'o'}, "<leader>fz", "<Cmd>Telescope frecency<CR>")

-- 翻訳
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(Translate)', {silent = true})
vim.api.nvim_set_keymap('v', 't', '<Plug>(VTranslate)', {silent = true})

-- タブ関連
vim.keymap.set({'n', 'x', 'o'}, 'tn', '<cmd>tabnew<cr>',{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', {silent = true, noremap = true})

-- 矩形選択
vim.keymap.set({'n', 'x', 'o'}, '<Leader>v', '<C-v>',{ noremap = true, silent = true })

-- 全選択
vim.keymap.set({'n', 'x', 'o'}, 'vv', 'G$Vgg0',{ noremap = true, silent = true })

vim.keymap.set({'n', 'x', 'o'}, 'dx', 'dd',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'dd', '"_dd',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'd', '"_d',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'c', '"_c',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'D', '"_D',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'C', '"_C',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'S', '"_S',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 's', '"_s',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'm', '^',{ noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '^', '+',{ noremap = true, silent = true })

-- ノーマル、ビジュアル、オペレータモードでのキーマッピング
vim.keymap.set({'n', 'x', 'o'}, 'o', 'o<esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'O', 'O<Esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '(', 'i<Space><Esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, ')', 'a<Space><Esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '<Space>', '$', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'J', '10j', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'K', '10k', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'd ', 'diw', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'c ', 'ciw', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'y ', 'yiw', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gu ', 'guiw', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gU ', 'gUiw', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'v ', 'viw', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, ',', ';', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'Q', ',', { noremap = true, silent = true })

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
