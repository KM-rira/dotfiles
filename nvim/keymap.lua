-- ========================================================================
-- shared vscode keymap start
-- ========================================================================

-- リーダーキーの設定
vim.g.mapleader = ";"

vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":nohlsearch<CR><ESC>", {})

-- save
-- vim.keymap.set({ "n", "x", "o" }, "<C-s>", "G$Vgg0<C-=>:w<CR>", opts)
-- vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>", opts)

-- タブ関連
vim.keymap.set({ "n", "x", "o" }, "tn", "<cmd>tabnew<cr>", { noremap = true, silent = true })

-- 矩形選択
vim.keymap.set({ "n", "x", "o" }, "<Leader>v", "<C-v>", { noremap = true, silent = true })

-- 全選択
vim.keymap.set({ "n", "x", "o" }, "vv", "G$Vgg0", { noremap = true, silent = true })

vim.keymap.set({ "n", "x", "o" }, "dx", "dd", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "d", '"_d', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "c", '"_c', { noremap = true, silent = true })
-- vim.keymap.set({ "n", "x", "o" }, "D", '"_dd', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "C", '"_C', { noremap = true, silent = true })
-- vim.keymap.set({ "n", "x", "o" }, "S", '"_C', { noremap = true, silent = true })
-- vim.keymap.set({ "n", "x", "o" }, "s", '"_s', { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "m", "^", { noremap = true, silent = true })
-- vim.keymap.set({ "n", "x", "o" }, "^", "+", { noremap = true, silent = true })

-- ノーマル、ビジュアル、オペレータモードでのキーマッピング
vim.keymap.set({ "n", "x", "o" }, "o", "o<esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "O", "O<Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "(", "i<Space><Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, ")", "a<Space><Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "<Space>", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "J", "5gj", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "K", "5gk", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "H", "5h", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "<C-m>", "M", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "<C-h>", "H", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "<C-l>", "L", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "L", "5l", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gJ", "5j", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gK", "5k", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, ",", ";", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "Q", ",", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "Y", "yy", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "<C-z>", "<C-a>", { noremap = true, silent = true })
vim.api.nvim_del_keymap('v', 'x')
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
--vim.keymap.set("i", "<C-n>", "<Down>", opts) -- 次の行へ
vim.keymap.set("i", "<C-p>", "<Up>", opts) -- 前の行へ
vim.keymap.set("i", "<C-a>", "<C-o>^", opts) -- 行の先頭へ
vim.keymap.set("i", "<C-e>", "<End>", opts) -- 行の末尾へ

-- 削除
vim.keymap.set("i", "<C-d>", "<Delete>", opts) -- カーソル下の文字を削除
--vim.keymap.set('i', '<C-h>', '<BS>', opts)        -- カーソル前の文字を削除
vim.keymap.set("i", "<C-w>", "<C-o>db", opts) -- 単語単位で削除
vim.keymap.set("i", "<C-u>", "<C-o>h<C-o>v^d", opts) -- 行の先頭からカーソル位置までを削除
vim.keymap.set("i", "<C-k>", "<C-o>D", opts) -- カーソルから行末までを削除
vim.keymap.set("i", "<M-d>", "<C-o>dw", opts) -- 次の単語を削除 (Alt + D)
vim.keymap.set("i", "<M-Backspace>", "<C-o>dw", opts) -- 前の単語を削除 (Alt + Backspace)
vim.keymap.set("i", "<M-b>", "<C-o>b", opts) -- 前の単語へ移動 (Alt + B)
vim.keymap.set("i", "<M-f>", "<C-o>w", opts) -- 次の単語へ移動

-- ペースト
-- vim.keymap.set('i', '<C-y>', '<C-r>"', opts)  -- 元に戻す
vim.keymap.set("i", "<C-_>", "<C-o>u", opts) -- 次の単語を削除 (Alt + D)

-- todo系
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "M", CenterCursorOnLine, { desc = "Move cursor to the center of the current line" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
end, { desc = "Next error/warning todo comment" })

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
vim.api.nvim_set_keymap("i", "<C-y>", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("s", "<C-y>", "", { noremap = true, silent = true })

vim.keymap.set({"i", "t"}, "jk", "<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n>", { noremap = true })

-- tarminal mode exit
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- ========================================================================
-- shared vscode keymap end
-- ========================================================================
vim.keymap.set({ "n", "x", "o" }, "j", "gj", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "k", "gk", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gj", "j", { noremap = true, silent = true })
vim.keymap.set({ "n", "x", "o" }, "gk", "k", { noremap = true, silent = true })

-- lsp系
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gd', '<Plug>(coc-definition)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gt', '<Plug>(coc-type-definition)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gc', '<Plug>(coc-declaration)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gi', '<Plug>(coc-implementation)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gr', '<Plug>(coc-references)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gn', '<Plug>(coc-rename)',{ noremap = true, silent = true })
-- vim.keymap.set({'n', 'x', 'o'},'<leader>gh', ':call CocAction(\'doHover\')<CR>',{ noremap = true, silent = true })
vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })

local builtin = require("telescope.builtin")

local opts = {
	previewer = true,
	layout_strategy = "vertical", -- ← プレビューを下に表示
	layout_config = {
		preview_height = 0.5, -- プレビューウィンドウの高さ（画面の50%）
		width = 0.95,
		height = 0.90,
	},
	path_display = { "smart" },
}

vim.keymap.set("n", "gr", function()
	builtin.lsp_references(opts)
end, { noremap = true, silent = true })

vim.keymap.set("n", "gd", function()
	builtin.lsp_definitions(opts)
end, { noremap = true, silent = true })

vim.keymap.set("n", "gi", function()
	builtin.lsp_implementations(opts)
end, { noremap = true, silent = true })

vim.keymap.set("n", "gt", function()
	builtin.lsp_type_definitions(opts)
end, { noremap = true, silent = true })

vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

-- telescope系
local builtin = require("telescope.builtin")

local smart_path = { path_display = { "smart" } }

vim.keymap.set({ "n", "x", "o" }, "<leader>ff", function()
	builtin.find_files(smart_path)
end, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fg", function()
	builtin.live_grep(smart_path)
end, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fb", builtin.buffers, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fo", function()
	builtin.oldfiles(smart_path)
end, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fc", builtin.commands, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fh", builtin.command_history, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fj", builtin.jumplist, {})
vim.keymap.set({ "n", "x", "o" }, "<leader>fz", "<Cmd>Telescope frecency<CR>")
vim.keymap.set({ "n", "x", "o" }, "<leader>fs", function()
	builtin.git_status(smart_path)
end, {})

-- =======================================================
-- git conflicts start
-- =======================================================
-- 次の衝突箇所に移動
vim.keymap.set("n", "<leader>cn", "<cmd>GitConflictNextConflict<CR>", { noremap = true, silent = true })

-- 前の衝突箇所に移動
vim.keymap.set("n", "<leader>cN", "<cmd>GitConflictPrevConflict<CR>", { noremap = true, silent = true })

-- 衝突解決：自分側（ours）を採用: main側
vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<CR>", { noremap = true, silent = true })

-- 衝突解決：相手側（theirs）を採用: dev側
vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<CR>", { noremap = true, silent = true })

-- 衝突解決：両方（both）を採用
vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<CR>", { noremap = true, silent = true })

-- 衝突解決：どちらも採用しない（none）
vim.keymap.set("n", "<leader>cn", "<cmd>GitConflictChooseNone<CR>", { noremap = true, silent = true })

-- コンフリクトリストの表示
vim.keymap.set("n", "<leader>cl", "<cmd>GitConflictList<CR>", { noremap = true, silent = true })
-- =======================================================
-- git conflicts end
-- =======================================================

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })

-- barbar系
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- バッファの移動
map("n", "<A->>", ":BufferLineMoveNext<CR>", opts)
map("n", "<A-<>", ":BufferLineMovePrev<CR>", opts)

-- 特定のバッファへの移動
map("n", "<leader>b1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>b2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>b3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>b4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>b5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>b6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>b7", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<leader>b8", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<leader>b9", ":BufferLineGoToBuffer 9<CR>", opts)

-- バッファの閉じるコマンド
map("n", "<leader>bo", ":BufferLineCloseOther<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>br", ":BufferLineCloseRight<CR>", opts)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)
map("n", "<leader>bp", ":BufferLinePick<CR>", opts)

map("n", "<leader>be", ":BufferLineSortByExtension<CR>", opts)
map("n", "<leader>bd", ":BufferLineSortByRelativeDirectory<CR>", opts)

-- Resize windows with arrow keys (便利)
vim.keymap.set("n", "<C-Up>", "<C-w>+")
vim.keymap.set("n", "<C-Down>", "<C-w>-")
vim.keymap.set("n", "<C-Left>", "<C-w><")
vim.keymap.set("n", "<C-Right>", "<C-w>>")

-- Insert Mode: <Shift-Insert> をシステムクリップボードからのペーストに割り当てる
vim.keymap.set('i', '<S-Insert>', '<C-r>+', { silent = true })

vim.api.nvim_set_keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true })

-- copilot系
vim.keymap.set("i", "<C-G>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- dap key map
vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F11>", ":DapStepInto<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>dB",
	':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>dp",
	':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dl", ':lua require("dap").run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dw", ':lua require("dapui").toggle()<CR>', {})
vim.api.nvim_set_keymap("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"gl",
	"<cmd>lua vim.diagnostic.setloclist({open = true, bufnr = 0})<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"ga",
	"<cmd>lua vim.diagnostic.setqflist({open = true})<CR>",
	{ noremap = true, silent = true }
)

-- Normalモードで ;fl
vim.keymap.set("n", ";fl", function()
	vim.cmd("Sr")
end, { noremap = true, silent = true })

-- Visualモードで ;fl
vim.keymap.set("v", ";fl", function()
	vim.cmd("Sr")
end, { noremap = true, silent = true })

-- Normalモードで ;fn
vim.keymap.set("n", ";fn", function()
	vim.cmd("Sf")
end, { noremap = true, silent = true })

-- Visualモードで ;fn
vim.keymap.set("v", ";fn", function()
	vim.cmd("Sf")
end, { noremap = true, silent = true })

-- Normal Mode: <C-x>f で Emacs の find-file のような操作を実現
vim.keymap.set('n', '<C-x>f',
  -- コマンドラインに ':e ' を入力し、続けて現在のカレントディレクトリ(getcwd())を挿入
  ':e <C-R>=getcwd()<CR>/',
  { silent = true, noremap = true, desc = 'Emacs C-x C-f style file find' }
)

if vim.g.neovide then

  -- 初期ズーム倍率
  vim.g.neovide_scale_factor = 1.0

  local function change_scale(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  end

  -- 🔍 ズームイン（Ctrl +）
  vim.keymap.set("n", "<C-=>", function() change_scale(0.1) end) -- "=" の Ctrl
  vim.keymap.set("n", "<C-+>", function() change_scale(0.1) end) -- "+" の Ctrl（Shift含む環境用）

  -- 🔎 ズームアウト（Ctrl -）
  vim.keymap.set("n", "<C-->", function() change_scale(-0.1) end)

  -- 🔁 リセット（Ctrl 0）
  vim.keymap.set("n", "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end)

  -- カーソルアニメーション完全OFF
  vim.g.neovide_cursor_animation_length = 0

  -- カーソルの残像なし
  vim.g.neovide_cursor_trail_length = 0

  -- スクロールアニメーション完全OFF
  vim.g.neovide_scroll_animation_length = 0

  -- VFX（炎・粒子など）無効化
  vim.g.neovide_cursor_vfx_mode = ""

  -- 透明度設定（1.0 = 完全不透明）
  -- ※ neovide_transparency は廃止され opacity に変更されました
  vim.g.neovide_opacity = 1.0

  -- GUIで24bitカラーを使う（Neovideでは推奨）
  vim.o.termguicolors = true

    -- OSごとの貼り付けキー設定
    local uname = vim.loop.os_uname().sysname

    if vim.g.neovide then
      if uname == "Darwin" then
        -- Mac: Cmd+V
        vim.g.neovide_input_use_logo = 1
        vim.g.neovide_input_mappings = {
          ["<D-v>"] = "<C-r>+",
        }

        vim.keymap.set('n', '<D-v>', '"+p')
        vim.keymap.set('i', '<D-v>', '<C-r>+')
        vim.keymap.set('c', '<D-v>', '<C-r>+')
        vim.keymap.set('t', '<D-v>', function()
          vim.api.nvim_feedkeys(vim.fn.getreg('+'), 'n', false)
        end)

      else
        -- Windows / Linux: Ctrl+V
        vim.g.neovide_input_mappings = {
          ["<C-v>"] = "<C-r>+",
        }

        vim.keymap.set('n', '<C-v>', '"+p')
        vim.keymap.set('i', '<C-v>', '<C-r>+')
        vim.keymap.set('c', '<C-v>', '<C-r>+')
        vim.keymap.set('t', '<C-v>', function()
          vim.api.nvim_feedkeys(vim.fn.getreg('+'), 'n', false)
        end)
      end
    end
end

function _G.ToggleCase()
    local word = vim.fn.expand("<cword>")

    if word == "" then
        return
    end

    -- === 1. スネークケース (snake_case) から キャメルケース (PascalCase) へ ===
    -- 判定: 単語にアンダースコア'_'が含まれている場合
    if word:match("_") then
        local temp_word = word:lower()

        -- _の次の文字を大文字にする (例: my_variable -> myVariable)
        local camel_pattern = "_(.)"
        local camel_result = temp_word:gsub(camel_pattern, function(capture)
            return capture:upper()
        end)

        -- 【スネーク→キャメルの要件】: 変換後の結果の先頭文字を大文字にする
        local first_char = camel_result:sub(1, 1):upper()
        local rest_of_word = camel_result:sub(2)
        local final_camel_result = first_char .. rest_of_word

        vim.cmd('normal! ciw' .. final_camel_result)
        return
    end

    -- === 2. キャメルケース (camelCase) から スネークケース (snake_case) へ ===

    -- 最初に、元の単語を使ってスネークパターンを適用する
    local snake_pattern = "([a-z])([A-Z])"
    -- (例: SmartCtrl) → (Smart_ctrl)
    local snake_temp_result = word:gsub(snake_pattern, function(c1, c2)
        -- 大文字の前に '_' を挿入し、大文字を小文字に戻す (ただし先頭文字は大文字のままの可能性あり)
        return c1 .. "_" .. c2:lower()
    end)

    -- 元の単語に大文字が含まれていた場合、またはパターンマッチングが成功した場合
    if snake_temp_result ~= word or word:match("[A-Z]") then
        -- 【キャメル→スネークの要件】: 最終的な結果をすべて小文字にする
        -- (例: Smart_ctrl) → (smart_ctrl)
        local final_snake_result = snake_temp_result:lower()

        vim.cmd('normal! ciw' .. final_snake_result)
        return
    end

    -- どちらのケースでもない場合（すべて小文字の単語など）は何もしない
end
-- ノーマルモード
vim.keymap.set('n', '<leader>sc', '<cmd>lua ToggleCase()<CR>', { desc = 'Toggle case (camel/snake)' })

-- ビジュアルモード（選択範囲全体を処理する場合など、この関数ではカーソル下の単語を処理するため、nmapだけで十分なことが多いですが、設定の例として）
-- 厳密には、ビジュアルモードで選択したテキストに対して上記の関数を適用するためには、関数自体を修正する必要があります。
-- ここではカーソル下の単語を対象としているため、nmapのみで十分です。
