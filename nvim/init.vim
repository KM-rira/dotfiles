set encoding=utf-8
scriptencoding utf-8
let mapleader = ";"
set termguicolors
set ignorecase
set smartcase

"----------------------------------------
" プラグインを追加
"----------------------------------------
"neovim特有の設定"
set shellcmdflag=-c

call plug#begin('~/.vim/plugged')
" NERDTree プラグイン
Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" ヘルプ日本語化
Plug 'vim-jp/vimdoc-ja'

" インデントの階層色設定
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'lukas-reineke/indent-blankline.nvim'
" ステータスライン
Plug 'nvim-lualine/lualine.nvim'

" ファイル検索
Plug 'ctrlpvim/ctrlp.vim'

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" カラースキーム
Plug 'joshdick/onedark.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

" golang
Plug 'mattn/vim-goimports'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-telescope/telescope-frecency.nvim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'leoluz/nvim-dap-go'

" 単語をハイライト
Plug 'RRethy/vim-illuminate'
" 色コードを色付け
Plug 'norcalli/nvim-colorizer.lua'
" スタート画面設定
Plug 'goolord/alpha-nvim'
" スクロールバー設定
Plug 'petertriho/nvim-scrollbar'
" if 等にマッチするものを強調する
Plug 'andymass/vim-matchup'
" 括弧を自動で閉じる
Plug 'windwp/nvim-autopairs'
" SQLを大文字にする
Plug 'jsborjesson/vim-uppercase-sql'
" VScode的な差分表示をする
Plug 'lewis6991/gitsigns.nvim'
" コンフリクトをわかりやすくする
Plug 'akinsho/git-conflict.nvim'
" テストコード実行プラグイン
Plug 'klen/nvim-test'
" commentout
Plug 'numToStr/Comment.nvim'
" サイドバー設定
Plug 'sidebar-nvim/sidebar.nvim'
" terminal拡張
Plug 'akinsho/toggleterm.nvim', { 'tag': '*' }
" minimap
Plug 'wfxr/minimap.vim'
Plug 'gorbit99/codewindow.nvim'
" スクロールがなめらか
Plug 'karb94/neoscroll.nvim'
" インデントをきれいにする
Plug 'aruyu/nvim-ultivisual'
" スクロールするときの末尾が少し余白あり
Plug 'Aasim-A/scrollEOF.nvim'
" オブジェクトに関するバーを表示
Plug 'utilyre/barbecue.nvim'
" 翻訳
Plug 'hotoolong/translate.nvim'
call plug#end()

"----------------------------------------------------------
" lua
"----------------------------------------------------------
lua require('scrollEOF').setup()
lua require('nvim-ultivisual').setup()
lua require('neoscroll').setup()
lua << EOF
require('codewindow').setup()
EOF
" ミニマップの自動表示
let g:minimap_auto_start = 1
" ミニマップの自動トグル
"let g:minimap_auto_toggle = 1
lua << EOF
require("toggleterm").setup{
  -- ここに設定を追加
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal'
}
EOF
lua << EOF
local sidebar = require("sidebar-nvim")
local opts = {open = true}
sidebar.setup(opts)
EOF
lua << EOF
local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}
EOF
lua << EOF
require('Comment').setup({
    ---コメントと行の間にスペースを追加
    padding = true,
    ---カーソルがその位置に留まるべきかどうか
    sticky = true,
    ---コメントの追加/削除時に無視する行
    ignore = nil,
    ---NORMALモードでのトグルマッピングの左側
    toggler = {
        ---行コメントのトグルキーマップ
        line = 'gcc',
        ---ブロックコメントのトグルキーマップ
        block = 'gbc',
    },
    ---NORMALおよびVISUALモードでの操作待ちマッピングの左側
    opleader = {
        ---行コメントのキーマップ
        line = 'gc',
        ---ブロックコメントのキーマップ
        block = 'gb',
    },
    ---追加のマッピングの左側
    extra = {
        ---上の行にコメントを追加
        above = 'gcO',
        ---下の行にコメントを追加
        below = 'gco',
        ---行の末尾にコメントを追加
        eol = 'gcA',
    },
    ---キーバインディングを有効にする
    ---注記: `false`を指定すると、プラグインはいかなるマッピングも作成しません
    mappings = {
        ---操作待ちマッピング; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---追加のマッピング; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---コメントの追加/削除前に呼び出される関数
    pre_hook = nil,
    ---コメントの追加/削除後に呼び出される関数
    post_hook = nil,
})
EOF
lua << EOF
require('nvim-test').setup({
  mappings = {
    nearest = '<leader>dt',  -- 現在のカーソル位置に最も近いテストを実行
    file = '<leader>dT',     -- 現在のファイルのテストを実行
    suite = '<leader>da',    -- すべてのテストを実行
    last = '<leader>dl',     -- 最後に実行したテストを再実行
    visit = '<leader>df',    -- 最後に実行したテストのファイルを開く
  }
})
EOF
lua << EOF
require('git-conflict').setup {
  default_mappings = true, -- disable buffer local mapping created by this plugin
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  list_opener = 'copen', -- command or function to open the conflicts list
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = 'DiffAdd',
    current = 'DiffText',
  }
}
EOF
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF
lua << EOF
require("nvim-autopairs").setup {}
EOF
lua << EOF
vim.g.matchup_matchparen_offscreen = { method = 'popup' }
EOF
lua << EOF
require('scrollbar').setup()
EOF
lua << EOF
require('alpha').setup(require('alpha.themes.startify').config)
EOF
lua << EOF
require 'colorizer'.setup(
  {'*';},          -- すべてのファイルタイプで有効にする
  {
    RGB      = true;         -- #RGB 形式を有効にする
    RRGGBB   = true;         -- #RRGGBB 形式を有効にする
    names    = true;         -- "blue" のような名前付きカラーを有効にする
    RRGGBBAA = true;         -- #RRGGBBAA 形式を有効にする
    rgb_fn   = true;         -- css rgb() および rgba() 関数を有効にする
    hsl_fn   = true;         -- css hsl() および hsla() 関数を有効にする
    css      = true;         -- css #RRGGBB 形式を有効にする
    css_fn   = true;         -- css 関数を有効にする
  }
)
EOF
lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF
lua << EOF
require('telescope').setup{
  defaults = {
    -- 他の設定...

    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}
EOF
lua << EOF
require'nvim-tree'.setup {
  -- netrw を完全に無効化
  disable_netrw = true,
  -- 起動時に netrw ウィンドウをハイジャック
  hijack_netrw = true,
  -- `DirChanged` でツリーのルートディレクトリを更新（通常は `:cd` を実行したとき）
  update_cwd = true,
  -- サインカラムに診断情報を表示
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  -- `BufEnter` でフォーカスされたファイルを更新し、ファイルが見つかるまでフォルダーを再帰的に展開
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {}
  },
  -- システムオープンコマンドの設定（デフォルトではツリー内の `s`）
  system_open = {
    cmd = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    -- ウィンドウの幅、数値（列）または `%` での文字列のいずれかにできる
    width = 30,
    -- ツリーの位置、'left' | 'right' | 'top' | 'bottom' のいずれか
    side = 'left',
    -- マッピングの設定は個別に行う
  }
}
EOF
lua << EOF
-- shortcut
local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F5>", ":lua require'dap'.continue()<CR>", { silent = true})
map("n", "<F10>", ":lua require'dap'.step_over()<CR>", { silent = true})
map("n", "<F11>", ":lua require'dap'.step_into()<CR>", { silent = true})
map("n", "<F12>", ":lua require'dap'.step_out()<CR>", { silent = true})
map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true})
map("n", "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true})
map("n", "<leader>l", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { silent = true})

-- dap-ui key map
map("n", "<leader>d", ":lua require'dapui'.toggle()<CR>", { silent = true})
map("n", "<leader><leader>df", ":lua require'dapui'.eval()<CR>", { silent = true})

-- dap-go key map
map("n", "<leader>td", ":lua require'dap-go'.debug_test()<CR>", { silent = true })

-- nvim-dap の基本設定
local dap = require("dap")
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
}

EOF
lua << EOF

-- nvim-dap-ui のUI設定
require('dapui').setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- カスタムキーマッピング
  },
  layouts = {
    {
      elements = {
        -- サイドバーのレイアウト設定
      },
      size = 40,
      position = 'left'
    },
    {
      elements = {
        -- トレイのレイアウト設定
      },
      size = 10,
      position = 'bottom'
    },
  }
})

EOF
lua << EOF
-- nvim-dap-go の設定
require('dap-go').setup()

local dap = require('dap')

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      return '127.0.0.1'
    end,
    port = function()
      local val = vim.fn.input('Port: ')
      return tonumber(val)
    end
  }
}

EOF

"----------------------------------------------------------
" クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"---------------------------------------
"キーバインド設定
"----------------------------------------
" 行番号表示
set number
" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" 全角文字専用の設定
set ambiwidth=double
" wildmenuオプションを有効(vimバーからファイルを選択できる)
set wildmenu

"----------------------------------------
" 検索
"----------------------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
" set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch

"----------------------------------------
" 表示設定
"----------------------------------------
set background=light
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" インデント方法の変更
set cinoptions+=:0
" メッセージ表示欄を2行確保
set cmdheight=2
" ステータス行を常に表示
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" コマンドラインの履歴を10000件保存する
set history=10000
" 入力モードでTabキー押下時に半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=4
" タブキー押下時に挿入される文字幅を指定
set softtabstop=4
" ファイル内にあるタブ文字の表示幅
set tabstop=4
" ツールバーを非表示にする
set guioptions-=T
" yでコピーした時にクリップボードに入る
set guioptions+=a
" メニューバーを非表示にする
set guioptions-=m
" 右スクロールバーを非表示
set guioptions+=R
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" スワップファイルを作成しない
set noswapfile
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" タイトルを表示
set title
" 行番号の表示
set number
" ヤンクでクリップボードにコピー
set clipboard=unnamedplus
" オートインデント
set autoindent
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" すべての数を10進数として扱う
set nrformats=
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~
" バッファスクロール （諸悪の根源）
" set mouse=a
" CRLFに改行コードを変更
set fileformat=unix
" インデントがスマートになる（らしい）
set smartindent
" 全角文字をちゃんと表示する
set ambiwidth=double
" 折り返したときにインデントする
set breakindent
" 折り返したときの追加のインデントの深さを指定する
set breakindentopt=shift:0

set shellslash

" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" auto comment off
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" HTML/XML閉じタグ自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"----------------------------------------
" コマンドマッピング
"----------------------------------------
command! Pi PlugInstall
command! Pu PlugUpdate
command! Pc PlugClean
command! Ps PlugStatus
command! Gr GoReferrers
command! Gd GoDef
command! Tr terminal
command! Mp MarkdownPreview
command! Vt vsplit | terminal
command! Ht split | terminal
command! Rc :edit $MYVIMRC
command! Re :source ~/.config/nvim/init.vim
command! Nf NvimTreeFindFile
command! Nt NvimTreeToggle
command! St SidebarNvimToggle
command! Ch checkhealth
cabbrev Ner NERDTreeToggle


"----------------------------------------
" ショートカットキー(shortcut)
"----------------------------------------
" coc系
nmap <leader>d <Plug>(coc-definition)
omap <leader>d <Plug>(coc-definition)
xmap <leader>d <Plug>(coc-definition)

nmap <leader>t <Plug>(coc-type-definition)
omap <leader>t <Plug>(coc-type-definition)
xmap <leader>t <Plug>(coc-type-definition)

nmap <leader>c <Plug>(coc-declaration)
omap <leader>c <Plug>(coc-declaration)
xmap <leader>c <Plug>(coc-declaration)

nmap <leader>i <Plug>(coc-implementation)
omap <leader>i <Plug>(coc-implementation)
xmap <leader>i <Plug>(coc-implementation)

nmap <leader>r <Plug>(coc-references)
omap <leader>r <Plug>(coc-references)
xmap <leader>r <Plug>(coc-references)

nmap <leader>re <Plug>(coc-rename)
omap <leader>re <Plug>(coc-rename)
xmap <leader>re <Plug>(coc-rename)

nmap <leader>h :call CocAction('doHover')<CR>
omap <leader>h :call CocAction('doHover')<CR>
xmap <leader>h :call CocAction('doHover')<CR>

" telescope系
nmap <leader>ff <cmd>Telescope find_files<cr>
nmap <leader>fb <cmd>Telescope buffers<cr>
nmap <leader>fo <cmd>Telescope oldfiles<cr>
nmap <leader>fcl <cmd>Telescope commands<cr>
nmap <leader>ft <cmd>Telescope tags<cr>
nmap <leader>fc <cmd>Telescope command_history<cr>
nmap <leader>fj <cmd>Telescope jumplist<cr>
nmap <leader>fs <cmd>Telescope search_history<cr>
nmap <leader>fz <cmd>Telescope frecency<cr>
nmap <leader>fl <cmd>Telescope live_grep<cr>

" 翻訳
nmap gr <Plug>(Translate)
vmap t <Plug>(VTranslate)

nmap nt <cmd>tabnew<cr>
omap nt <cmd>tabnew<cr>
xmap nt <cmd>tabnew<cr>

nnoremap vv G$Vgg0

nnoremap dx dd
nnoremap dd "_dd

nnoremap d "_d
xnoremap d "_d
onoremap d "_d

nnoremap c "_c
xnoremap c "_c
onoremap c "_c

nnoremap D "_D
xnoremap D "_D
onoremap D "_D

nnoremap C "_C
xnoremap C "_C
onoremap C "_C


nnoremap S "_S
xnoremap S "_S
onoremap S "_S

nnoremap s "_s
vnoremap s "_s
onoremap s "_s

nnoremap m ^
xnoremap m ^
onoremap m ^

nnoremap ^ +
xnoremap ^ +
onoremap ^ +

nnoremap o o<Esc>
xnoremap o o<Esc>
onoremap o o<Esc>

nnoremap O O<Esc>
xnoremap O O<Esc>
onoremap O O<Esc>

nnoremap ( i<Space><Esc> 
xnoremap ( i<Space><Esc> 
onoremap ( i<Space><Esc> 

nnoremap ) a<Space><Esc> 
xnoremap ) a<Space><Esc> 
onoremap ) a<Space><Esc> 

nnoremap <Space> $
xnoremap <Space> $
onoremap <Space> $

nnoremap J 10j
xnoremap J 10j
onoremap J 10j

nnoremap K 10k
xnoremap K 10k
onoremap K 10k


" ノーマルモードに移行
inoremap jk <Esc>

tnoremap <C-j> <C-\><C-n>
cnoreabbrev he help
" NerdTree開く
nnoremap <C-e> :NvimTreeToggle<CR>

command! Re source $MYVIMRC

" 編集中ファイル保存＆実行コマンド
function! s:RunCurrentFile()
    " Check if buffer is a normal file
    if &buftype != ''
        echo "Cannot run this buffer type"
        return
    endif

    " Save the current file
    write

    " Get the current file extension
    let l:filetype = expand('%:e')

    " Get the current file full path
    let l:fullpath = expand('%:p')

    " Convert Windows path to Unix style (WSL)
    let l:unixpath = substitute(l:fullpath, '\', '/', 'g')
    let l:unixpath = substitute(l:unixpath, '^C:', '/mnt/c', '')

    " run the appropriate command based on the file extension
    if l:filetype == 'py'
        execute '!python3' l:unixpath
    else
        echo "No run command for this file type."
    endif
endfunction

command! -nargs=0 W call s:RunCurrentFile()


"---------------------------------------
" カラースキーム　　
"---------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif

" カラースキームON
"colorscheme industry
"colorscheme nightfox
syntax on
colorscheme onedark
" ターミナル背景色
hi Terminal guibg=black
" インデントが最初からカラーリング
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=None   ctermbg=234
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=12 ctermbg=235
"let g:indent_guides_enable_on_vim_startup = 1

" 選択範囲の背景色を暗いオレンジに、文字色を黒に設定
highlight Visual ctermfg=black guifg=black ctermbg=202 guibg=#FFA500

" 行番号表示
set number
highlight LineNr ctermfg=8 ctermbg=235
" 現在の行番号の色設定
highlight CursorLineNr ctermfg=118 guifg=#FFD700
" 行を強調表示
set cursorline
"highlight CursorLine ctermbg=17
" 列を強調表示
"set cursorcolumn
"highlight CursorColumn cterm=none ctermbg=17
" 列強調OFF
set nocursorcolumn
" 全角強調
highlight ZenkakuSpace cterm=underline ctermfg=red guibg=blue ctermbg=blue
match ZenkakuSpace /　/
set hlsearch
highlight Search ctermfg=black ctermbg=91 cterm=NONE guifg=#000000 guibg=#FFA500
" コメントの字体変更
highlight Comment cterm=italic ctermfg=44
" Goの色設定
autocmd VimEnter,Colorscheme * :highlight goBuiltins ctermfg=201
autocmd VimEnter,Colorscheme * :highlight goKeyword ctermfg=196
" CRLFにする
"set mouse=a
set breakindent
" Nerdtree自動終了
autocmd BufEnter * if (winnr("$") == 1 && (bufname('') =~ 'NvimTree')) | q | endif

" nvimtreeの色
"hi NvimTreeFolderIcon guibg=blue
"hi NvimTreeFolderName guifg=blue
"hi NvimTreeIndentMarker guifg=#585858
"let g:Illuminate_delay = 500  " ハイライトまでの遅延時間をミリ秒で設定

" 正規表現を使用せずに置換する
function! Ch(word1, word2)
    let @/ = '\V' . escape(a:word1, '/')
    %s//\=a:word2/g
endfunction

" 正規表現を使用せずに一か所ずつ置換する
function! ConfirmReplace(args)
    let parts = split(a:args)
    let find = parts[0]
    let replace = parts[1]
    while 1
        let found = search('\V' . find, 'W')
        if !found
            echo "Not found!!"
            break
        endif
        let line_number = line('.')
        let column_number = col('.')
        call matchadd('Search', '\V' . find)
        redraw
        let user_input = ''
        while user_input != 'y' && user_input != 'n'
            let user_input = input('change ok?(y/n) ')
            if user_input == 'y'
                call matchdelete(matchadd('Search', '\V' . find))
                execute 's/\V' . find . '/' . replace . '/'
                echo "Done"
            elseif user_input == 'n'
                call matchdelete(matchadd('Search', '\V' . find))
                echo "Chi command end..."
                return
            else
                echo "Invalid input! Please enter y or n."
            endif
        endwhile
        call cursor(line_number, column_number)
    endwhile
endfunction

command! -nargs=1 Chi call ConfirmReplace(<q-args>)

function! SearchAndGrep(search_word, search_path)
    " グレップコマンドを使用して検索を行います。
    execute 'grep -rn ' . a:search_word . ' ' . a:search_path
    copen
endfunction

command! -nargs=+ SearchAndGrep call SearchAndGrep(<f-args>)

" クリップボードが使用可能
set clipboard&
set clipboard^=unnamedplus

let g:mkdp_preview_options = {
  \ 'mkit': {},
  \ 'katex': {},
  \ 'uml': {},
  \ 'maid': {},
  \ 'disable_sync_scroll': 0,
  \ 'sync_scroll_type': 'middle',
  \ 'hide_yaml_meta': 1,
  \ 'sequence_diagrams': {},
  \ 'flowchart_diagrams': {},
  \ 'content_editable': v:false,
  \ 'disable_filename': 0
  \ }

let g:mkdp_port = '5000'

let g:nvim_tree_window_picker_exclude = {
    \ 'filetype': ['notify', 'packer', 'qf'],
    \ 'buftype': ['terminal']
    \ }

command! -nargs=+ Replace call ReplaceFunc(<f-args>)

function! ReplaceFunc(search, replace)
    execute '%s/'.a:search.'/'.a:replace.'/g'
endfunction

command! -nargs=+ ReplaceOne call ReplaceOneFunc(<f-args>)

function! ReplaceOneFunc(search, replace)
    execute '%s/'.a:search.'/'.a:replace.'/gc'
endfunction

func! RemoveCR()
    %s/\r//ge
endfunc

autocmd BufWritePre * call RemoveCR()

command! Sd call SearchDollar()
function! SearchDollar()
    let searchPattern = '\$'
    let result = search(searchPattern)

    if result == 0
        echo "'$' not found."
    endif
endfunction

" Windows のクリップボードと統合するための設定
if has('wsl')
  set clipboard=unnamedplus
  let g:clipboard = {
    \   'name': 'win32yank-wsl',
    \   'copy': {
    \      '+': 'win32yank.exe -i --crlf',
    \      '*': 'win32yank.exe -i --crlf',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o --lf',
    \      '*': 'win32yank.exe -o --lf',
    \   },
    \   'cache_enabled': 0,
    \ }
endif

