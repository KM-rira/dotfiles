-- リーダーキーの設定
vim.g.mapleader = ';'

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>', {})

-- barbar系
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- save
vim.keymap.set({'n', 'x', 'o'}, '<C-s>', ':w<CR>', opts)
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>', opts)

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
vim.keymap.set({'n', 'x', 'o'}, 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gj', 'j', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gk', 'k', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'o', 'o<esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'O', 'O<Esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '(', 'i<Space><Esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, ')', 'a<Space><Esc>', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, '<Space>', '$', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'J', '10gj', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'K', '10gk', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gJ', '10j', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gK', '10k', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, ',', ';', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'Q', ',', { noremap = true, silent = true })
vim.keymap.set('n', 'd ', '"_diw', { noremap = true, silent = true })
vim.keymap.set('n', 'c ', '"_ciw', { noremap = true, silent = true })
vim.keymap.set('n', 'y ', 'yiw', { noremap = true, silent = true })
vim.keymap.set('n', 'gu ', 'guiw', { noremap = true, silent = true })
vim.keymap.set('n', 'gU ', 'gUiw', { noremap = true, silent = true })
-- insert mode setting
vim.keymap.set('i', 'ｊｋ', '<Esc>', { noremap = true, silent = true })

-- Emacs風のキー設定をインサートモードに適用
local opts = { noremap = true, silent = true }
-- カーソル移動
vim.keymap.set('i', '<C-f>', '<Right>', opts)    -- 前方へ
vim.keymap.set('i', '<C-b>', '<Left>', opts)     -- 後方へ
vim.keymap.set('i', '<C-n>', '<Down>', opts)     -- 次の行へ
vim.keymap.set('i', '<C-p>', '<Up>', opts)       -- 前の行へ
vim.keymap.set('i', '<C-a>', '<Home>', opts)     -- 行の先頭へ
vim.keymap.set('i', '<C-e>', '<End>', opts)      -- 行の末尾へ

-- 削除
vim.keymap.set('i', '<C-d>', '<Delete>', opts)    -- カーソル下の文字を削除
vim.keymap.set('i', '<C-h>', '<BS>', opts)        -- カーソル前の文字を削除
vim.keymap.set('i', '<C-w>', '<C-o>db', opts)     -- 単語単位で削除
vim.keymap.set('i', '<C-u>', '<C-o>h<C-o>v0d', opts)    -- 行の先頭からカーソル位置までを削除
vim.keymap.set('i', '<C-k>', '<C-o>D', opts)      -- カーソルから行末までを削除
vim.keymap.set('i', '<M-d>', '<C-o>dw', opts) -- 次の単語を削除 (Alt + D)
vim.keymap.set('i', '<M-Backspace>', '<C-o>dw', opts) -- 前の単語を削除 (Alt + Backspace)
vim.keymap.set('i', '<M-b>', '<C-o>b', opts) -- 前の単語へ移動 (Alt + B)
vim.keymap.set('i', '<M-f>', '<C-o>w', opts)         -- 次の単語へ移動

-- ペースト
-- vim.keymap.set('i', '<C-y>', '<C-r>"', opts)  -- 元に戻す
vim.keymap.set('i', '<C-_>', '<C-o>u', opts)  -- 次の単語を削除 (Alt + D)

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
