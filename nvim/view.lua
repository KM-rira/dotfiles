
-- カラースキーム設定
vim.cmd 'hi clear'
if vim.fn.exists("syntax_on") ~= 0 then
  vim.cmd 'syntax reset'
end

vim.cmd 'syntax on'
-- vim.cmd 'colorscheme onedark'
-- vim.cmd[[colorscheme tokyonight-storm]]
vim.cmd[[colorscheme catppuccin-frappe]]

-- ターミナル背景色
vim.cmd 'hi Terminal guibg=black'

-- 選択範囲の背景色と文字色
vim.cmd 'highlight Visual ctermfg=black guifg=black ctermbg=202 guibg=#FFA500'

-- 行番号表示
vim.o.number = true
vim.cmd 'highlight LineNr ctermfg=8 ctermbg=235'

-- 現在の行番号の色設定
vim.cmd 'highlight CursorLineNr ctermfg=118 guifg=#FFD700'

-- 行を強調表示
vim.o.cursorline = true

-- 列強調OFF
vim.o.cursorcolumn = false

-- 全角強調
vim.cmd 'highlight ZenkakuSpace cterm=underline ctermfg=red guibg=blue ctermbg=blue'
vim.cmd 'match ZenkakuSpace /　/'

-- 検索結果のハイライト
vim.o.hlsearch = true
vim.cmd 'highlight Search ctermfg=black ctermbg=91 cterm=NONE guifg=#000000 guibg=#FFA500'

-- コメントのフォントスタイル変更
vim.cmd 'highlight Comment cterm=italic ctermfg=44'

-- Go言語の色設定
vim.cmd 'autocmd VimEnter,Colorscheme * :highlight goBuiltins ctermfg=201'
vim.cmd 'autocmd VimEnter,Colorscheme * :highlight goKeyword ctermfg=196'

