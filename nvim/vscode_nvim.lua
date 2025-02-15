-- vscodeで、j, kが動作しない場合は、で、
-- defaults write -g ApplePressAndHoldEnabled -bool false
-- リーダーキーの設定
vim.g.mapleader = ";"

vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":nohlsearch<CR><ESC>", {})

-- 矩形選択
vim.keymap.set({ "n", "x", "o" }, "<Leader>v", "<C-v>", { noremap = true, silent = true })

-- 全選択
vim.keymap.set({ "n", "x", "o" }, "vv", "G$Vgg0", { noremap = true, silent = true })

vim.keymap.set({ "n", "x", "o" }, "dx", "dd", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "d", '"_d', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "c", '"_c', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "D", '"_D', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "C", '"_C', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "S", '"_S', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "s", '"_s', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "m", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "^", "+", { noremap = true, silent = true })

-- ノーマル、ビジュアル、オペレータモードでのキーマッピング
vim.keymap.set({ "n", "x", "o" }, "j", "gj", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "k", "gk", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gj", "j", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gk", "k", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "o", "o<esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "O", "O<Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "(", "i<Space><Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, ")", "a<Space><Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "<Space>", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "J", "10gj", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "K", "10gk", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gJ", "10j", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gK", "10k", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, ",", ";", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "Q", ",", { noremap = true, silent = true })
vim.keymap.set("n", "d ", '"_diw', { noremap = true, silent = true })
vim.keymap.set("n", "c ", '"_ciw', { noremap = true, silent = true })
vim.keymap.set("n", "y ", "yiw", { noremap = true, silent = true })
vim.keymap.set("n", "gu ", "guiw", { noremap = true, silent = true })
vim.keymap.set("n", "gU ", "gUiw", { noremap = true, silent = true })
-- single quote
vim.keymap.set("n", "dis", "\"_di'", { noremap = true, silent = true })
vim.keymap.set("n", "cis", "\"_ci'", { noremap = true, silent = true })
vim.keymap.set("n", "yis", "yi'", { noremap = true, silent = true })
vim.keymap.set("n", "guis", "gui'", { noremap = true, silent = true })
vim.keymap.set("n", "gUis", "gUi'", { noremap = true, silent = true })
vim.keymap.set("n", "das", "\"_da'", { noremap = true, silent = true })
vim.keymap.set("n", "cas", "\"_ca'", { noremap = true, silent = true })
vim.keymap.set("n", "yas", "ya'", { noremap = true, silent = true })
vim.keymap.set("n", "guas", "gua'", { noremap = true, silent = true })
vim.keymap.set("n", "gUas", "gUa'", { noremap = true, silent = true })
-- double quote
vim.keymap.set("n", "did", '"_di"', { noremap = true, silent = true })
vim.keymap.set("n", "cid", '"_ci"', { noremap = true, silent = true })
vim.keymap.set("n", "yid", 'yi"', { noremap = true, silent = true })
vim.keymap.set("n", "guid", 'gui"', { noremap = true, silent = true })
vim.keymap.set("n", "gUid", 'gUi"', { noremap = true, silent = true })
vim.keymap.set("n", "dad", '"_da"', { noremap = true, silent = true })
vim.keymap.set("n", "cad", '"_ca"', { noremap = true, silent = true })
vim.keymap.set("n", "yad", 'ya"', { noremap = true, silent = true })
vim.keymap.set("n", "guad", 'gua"', { noremap = true, silent = true })
vim.keymap.set("n", "gUad", 'gUa"', { noremap = true, silent = true })
-- reverse quote
vim.keymap.set("n", "dir", '"_di`', { noremap = true, silent = true })
vim.keymap.set("n", "cir", '"_ci`', { noremap = true, silent = true })
vim.keymap.set("n", "yir", "yi`", { noremap = true, silent = true })
vim.keymap.set("n", "guir", "gui`", { noremap = true, silent = true })
vim.keymap.set("n", "gUir", "gUi`", { noremap = true, silent = true })
vim.keymap.set("n", "dar", '"_da`', { noremap = true, silent = true })
vim.keymap.set("n", "car", '"_ca`', { noremap = true, silent = true })
vim.keymap.set("n", "yar", "ya`", { noremap = true, silent = true })
vim.keymap.set("n", "guar", "gua`", { noremap = true, silent = true })
vim.keymap.set("n", "gUar", "gUa`", { noremap = true, silent = true })
-- insert mode setting
vim.keymap.set("i", "ｊｋ", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- Emacs風のキー設定をインサートモードに適用
local opts = { noremap = true, silent = true }
-- カーソル移動
vim.keymap.set("i", "<C-f>", "<Right>", opts) -- 前方へ
vim.keymap.set("i", "<C-b>", "<Left>", opts) -- 後方へ
vim.keymap.set("i", "<C-n>", "<Down>", opts) -- 次の行へ
vim.keymap.set("i", "<C-p>", "<Up>", opts) -- 前の行へ
vim.keymap.set("i", "<C-a>", "<Home>", opts) -- 行の先頭へ
vim.keymap.set("i", "<C-e>", "<End>", opts) -- 行の末尾へ

-- 削除
vim.keymap.set("i", "<C-d>", "<Delete>", opts) -- カーソル下の文字を削除
--vim.keymap.set('i', '<C-h>', '<BS>', opts)        -- カーソル前の文字を削除
vim.keymap.set("i", "<C-w>", "<C-o>db", opts) -- 単語単位で削除
vim.keymap.set("i", "<C-u>", "<C-o>h<C-o>v0d", opts) -- 行の先頭からカーソル位置までを削除
vim.keymap.set("i", "<C-k>", "<C-o>D", opts) -- カーソルから行末までを削除
vim.keymap.set("i", "<M-d>", "<C-o>dw", opts) -- 次の単語を削除 (Alt + D)
vim.keymap.set("i", "<M-Backspace>", "<C-o>dw", opts) -- 前の単語を削除 (Alt + Backspace)
vim.keymap.set("i", "<M-b>", "<C-o>b", opts) -- 前の単語へ移動 (Alt + B)
vim.keymap.set("i", "<M-f>", "<C-o>w", opts) -- 次の単語へ移動

-- ペースト
-- vim.keymap.set('i', '<C-y>', '<C-r>"', opts)  -- 元に戻す
vim.keymap.set("i", "<C-_>", "<C-o>u", opts) -- 次の単語を削除 (Alt + D)

-- 選択しているものにクォートで囲う
-- single qutote
vim.api.nvim_set_keymap("n", "<leader>qs", "yiw\"_diwi''<Esc>P", { silent = true })
vim.api.nvim_set_keymap("v", "<leader>qs", "ygvdi''<Esc>P", { silent = true })
-- double qutote
vim.api.nvim_set_keymap("n", "<leader>qd", 'yiw"_diwi""<Esc>P', { silent = true })
vim.api.nvim_set_keymap("v", "<leader>qd", 'ygvdi""<Esc>P', { silent = true })
-- reserve qutote
vim.api.nvim_set_keymap("n", "<leader>qr", 'yiw"_diwi``<Esc>P', { silent = true })
vim.api.nvim_set_keymap("v", "<leader>qr", "ygvdi``<Esc>P", { silent = true })

-- クリップボード設定
vim.opt.clipboard:append("unnamedplus")
