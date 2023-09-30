set encoding=utf-8
scriptencoding utf-8

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
" ノーマルモードに移行
inoremap jj <Esc>

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
set smartcase
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
" バッファスクロール
set mouse=a
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
" プラグインを追加
"----------------------------------------
"neovim特有の設定"
set shellcmdflag=-c

call plug#begin('~/.vim/plugged')

" NERDTree プラグイン
Plug 'preservim/nerdtree'

" coc.nvim プラグイン
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 非同期補完プラグイン(<Plug>_廃止)
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" python プラグイン
"Plug 'deoplete-plugins/deoplete-jedi'

" ヘルプ日本語化
Plug 'vim-jp/vimdoc-ja'

" インデントの階層色設定
Plug 'nathanaelkane/vim-indent-guides'

" ステータスラインを表示
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Language Server Protocol
Plug 'neovim/nvim-lspconfig'

" ファイル検索
Plug 'ctrlpvim/ctrlp.vim'

" Go development
" go get golang.org/x/tools/gopls@latestを忘れずに
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Goの開発に必須のプラグイン
Plug 'neovim/nvim-lspconfig' " NeovimのLSPサポート
Plug 'hrsh7th/nvim-compe' " オートコンプリート

call plug#end()

" tabスラインを表示
let g:airline#extensions#tabline#enabled = 1

" LSPとvim-goの設定
autocmd FileType go setlocal ts=4 sw=4 expandtab
"let g:go_def_mode='gopls' " vim-goの定義ジャンプをgoplsで行う gopls廃止
let g:go_auto_type_info = 1 " カーソル下の型情報を自動的に表示

" LSP設定 （廃止）
"lua << EOF
"require'lspconfig'.gopls.setup{
"  cmd = {"gopls", "--remote=auto"};
"}
"EOF

" Compe設定
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:false

"deoplete有効化
let g:deoplete#enable_at_startup = 1

"----------------------------------------
" コマンドマッピング
"----------------------------------------
command! Pi PlugInstall
command! Pu PlugUpdate
command! Pc PlugClean
command! Gr GoReferrers
command! Gd GoDef
command! Tr terminal
nnoremap dx dd
nnoremap dd "_dd
nnoremap d "_d
xnoremap d "_d

tnoremap <C-j> <C-\><C-n>
cnoreabbrev he help
nnoremap <F2> <C-v>
vnoremap <F2> <C-v>
" NerdTree開く
nnoremap <C-e> :NERDTreeToggle<CR>

nnoremap <F5> :source $MYVIMRC<CR>

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
colorscheme industry

" インデントが最初からカラーリング
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=None   ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=12 ctermbg=235
let g:indent_guides_enable_on_vim_startup = 1

" 行番号表示
set number
highlight LineNr ctermfg=8 ctermbg=235
" 相対行表示
:set relativenumber
" 現在の行番号の色設定
highlight CursorLineNr ctermfg=154 ctermbg=2
" 行を強調表示
set cursorline
highlight CursorLine ctermbg=17
" 列を強調表示
"set cursorcolumn
"highlight CursorColumn cterm=none ctermbg=17
" 列強調OFF
set nocursorcolumn
" 全角強調
highlight ZenkakuSpace cterm=underline ctermfg=red guibg=blue ctermbg=blue
match ZenkakuSpace /　/
set hlsearch
highlight Search ctermfg=NONE ctermbg=91 cterm=NONE guifg=NONE guibg=#FFA500
" コメントの字体変更
highlight Comment cterm=italic ctermfg=44
" Goの色設定
autocmd VimEnter,Colorscheme * :highlight goBuiltins ctermfg=201
autocmd VimEnter,Colorscheme * :highlight goKeyword ctermfg=196
" CRLFにする
set mouse=a
set breakindent
" Nerdtree自動終了
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'nerdtree') | q | endif

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
