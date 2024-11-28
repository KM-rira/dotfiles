-- リーダーキーの設定
vim.g.mapleader = ';'

vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>', {})

-- barbar系
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- save
vim.keymap.set({'n', 'x', 'o'}, '<C-s>', 'G$Vgg0<C-=>:w<CR>', opts)
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
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gd', '<Plug>(coc-definition)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gt', '<Plug>(coc-type-definition)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gc', '<Plug>(coc-declaration)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gi', '<Plug>(coc-implementation)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gr', '<Plug>(coc-references)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gn', '<Plug>(coc-rename)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gh', ':call CocAction(\'doHover\')<CR>',{ noremap = true, silent = true })
vim.keymap.set('n', 'gh',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap=true, silent=true })
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- telescope系
local builtin = require('telescope.builtin')
vim.keymap.set({'n', 'x', 'o'}, 'ff', builtin.find_files, {})
vim.keymap.set({'n', 'x', 'o'}, 'fg', builtin.live_grep, {})
vim.keymap.set({'n', 'x', 'o'}, 'fb', builtin.buffers, {})
vim.keymap.set({'n', 'x', 'o'}, 'fo', builtin.oldfiles, {})
vim.keymap.set({'n', 'x', 'o'}, 'fc', builtin.commands, {})
vim.keymap.set({'n', 'x', 'o'}, 'fh', builtin.command_history, {})
vim.keymap.set({'n', 'x', 'o'}, 'fj', builtin.jumplist, {})
vim.keymap.set({'n', 'x', 'o'}, 'fs', builtin.search_history, {})
vim.keymap.set({'n', 'x', 'o'}, "fz", "<Cmd>Telescope frecency<CR>")

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
vim.keymap.set({'n', 'x', 'o'}, 'J', '5gj', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'K', '5gk', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gJ', '5j', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'gK', '5k', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, ',', ';', { noremap = true, silent = true })
vim.keymap.set({'n', 'x', 'o'}, 'Q', ',', { noremap = true, silent = true })
vim.keymap.set('n', 'd ', '"_diw', { noremap = true, silent = true })
vim.keymap.set('n', 'c ', '"_ciw', { noremap = true, silent = true })
vim.keymap.set('n', 'y ', 'yiw', { noremap = true, silent = true })
vim.keymap.set('n', 'gu ', 'guiw', { noremap = true, silent = true })
vim.keymap.set('n', 'gU ', 'gUiw', { noremap = true, silent = true })
-- single quote
vim.keymap.set('n', 'dis', '"_di\'', { noremap = true, silent = true })
vim.keymap.set('n', 'cis', '"_ci\'', { noremap = true, silent = true })
vim.keymap.set('n', 'yis', 'yi\'', { noremap = true, silent = true })
vim.keymap.set('n', 'guis', 'gui\'', { noremap = true, silent = true })
vim.keymap.set('n', 'gUis', 'gUi\'', { noremap = true, silent = true })
vim.keymap.set('n', 'das', '"_da\'', { noremap = true, silent = true })
vim.keymap.set('n', 'cas', '"_ca\'', { noremap = true, silent = true })
vim.keymap.set('n', 'yas', 'ya\'', { noremap = true, silent = true })
vim.keymap.set('n', 'guas', 'gua\'', { noremap = true, silent = true })
vim.keymap.set('n', 'gUas', 'gUa\'', { noremap = true, silent = true })
-- double quote
vim.keymap.set('n', 'did', '"_di\"', { noremap = true, silent = true })
vim.keymap.set('n', 'cid', '"_ci\"', { noremap = true, silent = true })
vim.keymap.set('n', 'yid', 'yi\"', { noremap = true, silent = true })
vim.keymap.set('n', 'guid', 'gui\"', { noremap = true, silent = true })
vim.keymap.set('n', 'gUid', 'gUi\"', { noremap = true, silent = true })
vim.keymap.set('n', 'dad', '"_da\"', { noremap = true, silent = true })
vim.keymap.set('n', 'cad', '"_ca\"', { noremap = true, silent = true })
vim.keymap.set('n', 'yad', 'ya\"', { noremap = true, silent = true })
vim.keymap.set('n', 'guad', 'gua\"', { noremap = true, silent = true })
vim.keymap.set('n', 'gUad', 'gUa\"', { noremap = true, silent = true })
-- reverse quote
vim.keymap.set('n', 'dir', '"_di`', { noremap = true, silent = true })
vim.keymap.set('n', 'cir', '"_ci`', { noremap = true, silent = true })
vim.keymap.set('n', 'yir', 'yi`', { noremap = true, silent = true })
vim.keymap.set('n', 'guir', 'gui`', { noremap = true, silent = true })
vim.keymap.set('n', 'gUir', 'gUi`', { noremap = true, silent = true })
vim.keymap.set('n', 'dar', '"_da`', { noremap = true, silent = true })
vim.keymap.set('n', 'car', '"_ca`', { noremap = true, silent = true })
vim.keymap.set('n', 'yar', 'ya`', { noremap = true, silent = true })
vim.keymap.set('n', 'guar', 'gua`', { noremap = true, silent = true })
vim.keymap.set('n', 'gUar', 'gUa`', { noremap = true, silent = true })
-- insert mode setting
vim.keymap.set('i', 'ｊｋ', '<Esc>', { noremap = true, silent = true })

vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

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
--vim.keymap.set('i', '<C-h>', '<BS>', opts)        -- カーソル前の文字を削除
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

-- 選択しているものにクォートで囲う
-- single qutote
vim.api.nvim_set_keymap('n', '<leader>qs', 'yiw"_diwi\'\'<Esc>P', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>qs', 'ygvdi\'\'<Esc>P', {silent = true})
-- double qutote
vim.api.nvim_set_keymap('n', '<leader>qd', 'yiw"_diwi\"\"<Esc>P', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>qd', 'ygvdi\"\"<Esc>P', {silent = true})
-- reserve qutote
vim.api.nvim_set_keymap('n', '<leader>qr', 'yiw"_diwi``<Esc>P', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>qr', 'ygvdi``<Esc>P', {silent = true})


-- ~/.config/nvim/init.lua

-- キーマッピングのオプション
local opts = { silent = true, noremap = true, expr = true }

-- -- インサートモードでのCtrl+jで次の補完候補を選択
-- vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#visible() ? coc#pum#next(1) : "\\<C-j>"', opts)
--
-- -- インサートモードでのCtrl+kで前の補完候補を選択
-- vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<C-k>"', opts)
--
-- -- インサートモードでのTabキーの設定（修正済み）
-- vim.api.nvim_set_keymap('i', '<Tab>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<Tab>"', opts)
--
-- -- インサートモードでのShift-Tabキーの設定
-- vim.api.nvim_set_keymap('i', '<S-Tab>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<S-Tab>"', opts)
--
-- -- セレクトモードでのTabキーの設定（必要に応じて）
-- vim.api.nvim_set_keymap('s', '<Tab>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<Tab>"', opts)
-- vim.api.nvim_set_keymap('s', '<S-Tab>', 'coc#pum#visible() ? coc#pum#prev(1) : "\\<S-Tab>"', opts)
--
-- `<Ctrl-y>` のマッピングを解除
vim.api.nvim_set_keymap('i', '<C-y>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<C-y>', '', { noremap = true, silent = true })

vim.keymap.set('i', 'jk', '<Esc>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap = true})

