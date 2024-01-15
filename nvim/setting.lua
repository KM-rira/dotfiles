-- エンコーディングの設定
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'

-- リーダーキーの設定
vim.g.mapleader = ';'

-- 色設定の有効化
vim.o.termguicolors = true

-- 検索設定
vim.o.ignorecase = true  -- 大文字と小文字を区別しない
vim.o.smartcase = true   -- 検索パターンに大文字が含まれている場合は大文字と小文字を区別

-- "neovim特有の設定"
vim.o.shellcmdflag = '-c'

vim.o.expandtab = true    -- タブをスペースに変換

-- 行番号表示
vim.o.number = true

-- バックアップを作らない
vim.o.writebackup = false
vim.o.backup = false

-- 仮想編集設定
vim.o.virtualedit = "block"

-- バックスペースの挙動
vim.o.backspace = "indent,eol,start"

-- 全角文字の設定
vim.o.ambiwidth = "double"

-- wildmenuオプション
vim.o.wildmenu = true

-- 検索設定
vim.o.wrapscan = true
vim.o.incsearch = true
vim.o.hlsearch = true

-- 表示設定
vim.o.background = "light"
vim.o.errorbells = false
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.cinoptions = vim.o.cinoptions .. ":0"
vim.o.cmdheight = 2
vim.o.laststatus = 2
vim.o.showcmd = true
vim.o.display = "lastline"
vim.o.list = true
--vim.o.listchars = "tab:^\ ,trail:~"
vim.o.history = 10000
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4
--vim.o.guioptions = vim.o.guioptions .. "-T" -- ツールバー非表示
--vim.o.guioptions = vim.o.guioptions .. "+a" -- yank時にクリップボードにコピー
--vim.o.guioptions = vim.o.guioptions .. "-m" -- メニューバー非表示
--vim.o.guioptions = vim.o.guioptions .. "+R" -- 右スクロールバー非表示
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.foldenable = false
vim.o.title = true
vim.o.clipboard = "unnamedplus"
vim.o.autoindent = true
vim.o.nrformats = ""
vim.o.whichwrap = "b,s,h,l,<,>,[,],~"
vim.o.mouse = "a"
vim.o.fileformat = "unix"
vim.o.ambiwidth = "double"
vim.o.breakindent = true
vim.o.breakindentopt = "shift:0"
--vim.o.shellslash = true
vim.cmd 'filetype plugin indent on'  -- ファイルタイプに基づくインデント設定を有効化

-- set completeopt
vim.o.completeopt = "menuone,noinsert"
-- 折り返しインデント
vim.o.breakindent = true

-- Nerdtree自動終了
vim.cmd 'autocmd BufEnter * if (winnr("$") == 1 && (bufname("") =~ "NvimTree")) | q | endif'
-- クリップボードが使用可能
vim.o.clipboard = "unnamedplus"

-- Markdown Previewの設定
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0

}
vim.g.mkdp_port = '5000'

-- NvimTreeのウィンドウピッカー除外設定
vim.g.nvim_tree_window_picker_exclude = {
    filetype = {'notify', 'packer', 'qf'},
    buftype = {'terminal'}
}

-- WindowsのWSLクリップボード統合設定
if vim.fn.has('wsl') == 1 then
  vim.o.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end
