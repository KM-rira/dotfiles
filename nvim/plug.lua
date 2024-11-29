vim.opt.termguicolors = true
-- Packer.nvimの初期化と設定
require('packer').startup(function(use)
    -- Packerを管理するために必要
    use 'wbthomason/packer.nvim'
    -- ここからプラグインのリスト
    -- use '~/repo/myplugin'
    use 'KM-rira/myplugin'
    use 'preservim/nerdtree'
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', tag = 'v1.8.0'}
    use 'vim-jp/vimdoc-ja'
    -- indent line廃止
    -- use {'lukas-reineke/indent-blankline.nvim', tag = 'v3.3.10'}
    use 'nvim-lualine/lualine.nvim'
    use 'ctrlpvim/ctrlp.vim'
    -- use {'neoclide/coc.nvim', branch = 'release'} -- tag v0.0.82-191-gf1ffb8d9
    -- use 'joshdick/onedark.vim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- 関数名などを上部に表示
    -- use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use {
        'mattn/vim-goimports',
        config = function()
            -- 保存時に自動で import を整理する設定
            vim.cmd [[
        augroup GoImports
        autocmd!
        autocmd BufWritePre *.go :GoImports
        autocmd BufWritePre *.go :silent !gofmt -w %
        augroup END
        ]]
        end
    }
    use {'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-frecency.nvim'}}
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npx --yes yarn install'}
    use 'RRethy/vim-illuminate'
    use 'goolord/alpha-nvim'
    -- use 'petertriho/nvim-scrollbar'
    use 'jsborjesson/vim-uppercase-sql'
    use 'lewis6991/gitsigns.nvim'
    use {'akinsho/git-conflict.nvim', tag = 'v1.3.0'}
    use {'klen/nvim-test', tag = '1.4.1'}
    use 'numToStr/Comment.nvim'
    use 'sidebar-nvim/sidebar.nvim'
    use {'akinsho/toggleterm.nvim', tag = 'v2.11.0'}
    -- use 'wfxr/minimap.vim'
    -- use 'gorbit99/codewindow.nvim'
    use 'karb94/neoscroll.nvim'
    --use 'Aasim-A/scroll.nvim'
    -- use 'utilyre/barbecue.nvim'
    use {'akinsho/bufferline.nvim', tag = 'v4.6.1'}

    -- 括弧自動補完
    use {'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    -- color themes
    use { "scottmckendry/cyberdream.nvim" }
    -- use { 'projekt0n/github-nvim-theme', name = 'github-theme' }
    -- use 'navarasu/onedark.nvim'
    -- use 'folke/tokyonight.nvim'
    -- use { "catppuccin/nvim", as = "catppuccin" }
    -- use 'rcarriga/nvim-notify'
    -- use 'folke/noice.nvim'

    -- git control
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    -- csv edit
    use 'hat0uma/csvview.nvim'

    -- add error customh ighlight
    use {
        'Kasama/nvim-custom-diagnostic-highlight',
        config = function()
            require('nvim-custom-diagnostic-highlight').setup {}
        end
    }

    -- file faster loader
    use {
        "LunarVim/bigfile.nvim",
    }

    -- search result count
    use {'kevinhwang91/nvim-hlslens'}
    use 'mg979/vim-visual-multi'

    use 'norcalli/nvim-colorizer.lua'
    use 'yamatsum/nvim-cursorline'
    use 'sindrets/diffview.nvim'
    -- use 'nvim-pack/nvim-spectre'

    -- lsp config
    use 'neovim/nvim-lspconfig' -- LSP設定用プラグイン
    use 'hrsh7th/nvim-cmp' -- オートコンプリートプラグイン
    use 'hrsh7th/cmp-nvim-lsp' -- LSPソースのためのnvim-cmp
    use 'L3MON4D3/LuaSnip' -- LuaSnip スニペットエンジン
    use 'saadparwaiz1/cmp_luasnip' -- LuaSnip ソース
    use 'rafamadriz/friendly-snippets' -- スニペットコレクション
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- nvim-dapと関連プラグイン
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'https://github.com/mfussenegger/nvim-dap-python'
use {
    'nvim-neotest/nvim-nio'
}

    use {
        'KM-rira/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
                -- ここに設定を追加
                -- またはデフォルト設定を使用するために空のままにする
                {
                    signs = true, -- show icons in the signs column
                    sign_priority = 8, -- sign priority
                    -- keywords recognized as todo comments
                    keywords = {
                        FIX = {
                            icon = "! ", -- icon used for the sign, and in search results
                            color = "error", -- can be a hex color, or a named color (see below)
                            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                            -- signs = false, -- configure signs for some keywords individually
                        },
                        TODO = { icon = "!  ", color = "info" },
                        HACK = { icon = "!  ", color = "warning" },
                        WARN = { icon = "!  ", color = "warning", alt = { "WARNING", "XXX" } },
                        PERF = { icon = "!  ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                        NOTE = { icon = "!  ", color = "hint", alt = { "INFO" } },
                        TEST = { icon = "!  ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                    },
                    gui_style = {
                        fg = "NONE", -- The gui style to use for the fg highlight group.
                        bg = "BOLD", -- The gui style to use for the bg highlight group.
                    },
                    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                    -- highlighting of the line containing the todo comment
                    -- * before: highlights before the keyword (typically comment characters)
                    -- * keyword: highlights of the keyword
                    -- * after: highlights after the keyword (todo text)
                    highlight = {
                        multiline = true, -- enable multine todo comments
                        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                        before = "", -- "fg" or "bg" or empty
                        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                        after = "fg", -- "fg" or "bg" or empty
                        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                        comments_only = true, -- uses treesitter to match keywords in comments only
                        max_line_len = 400, -- ignore lines longer than this
                        exclude = {}, -- list of file types to exclude highlighting
                    },
                    -- list of named colors where we try to extract the guifg from the
                    -- list of highlight groups or use the hex color if hl not found as a fallback
                    colors = {
                        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                        info = { "DiagnosticInfo", "#2563EB" },
                        hint = { "DiagnosticHint", "#10B981" },
                        default = { "Identifier", "#7C3AED" },
                        test = { "Identifier", "#FF00FF" }
                    },
                    search = {
                        command = "rg",
                        args = {
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                        },
                        -- regex that will be used to match keywords.
                        -- don't replace the (KEYWORDS) placeholder
                        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                    },
                }

            }
        end
    }
    -- その他のプラグインはここに追加...
end)

-- LSP設定
local nvim_lsp = require('lspconfig')

-- LuaSnipをロード
local luasnip = require 'luasnip'

-- friendly-snippetsからスニペットを読み込む
require("luasnip.loaders.from_vscode").lazy_load()

-- オートコンプリートの設定
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- LuaSnipを使用してスニペットを展開
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- 確定
        ['<C-j>'] = cmp.mapping.select_next_item(), -- 次の補完候補を選択
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- 前の補完候補を選択
        -- LuaSnip 用のマッピング
        ['<C-l>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- LuaSnipをソースとして追加
        -- 必要に応じて他のソースを追加
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
})

-- LSPサーバーの設定例: pyright
-- LSPの設定を読み込む
local nvim_lsp = require('lspconfig')

-- 共通の on_attach 関数を定義
local on_attach = function(client, bufnr)
    -- バッファローカルのキー設定を容易にするためのショートカット
    local opts = { noremap=true, silent=true, buffer=bufnr }

    --   vim.g.mapleader = ';'
    -- -- キーマッピングの設定
    -- vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>gc', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<leader>gh', vim.lsp.buf.hover, opts)
    --
    -- -- 追加のキーマッピング例
    -- -- コードアクションを実行
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- -- シグネチャヘルプを表示
    -- vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, opts)
end

-- 使用するLSPサーバーの設定例（goplsを例に）
nvim_lsp.gopls.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

-- 他のLSPサーバーも同様に設定
-- 例: pyright
nvim_lsp.pyright.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "tsserver", "gopls" }, -- 必要なLSPサーバーを列挙
})

local lspconfig = require('lspconfig')

require("mason-lspconfig").setup_handlers {
    function (server_name)
        lspconfig[server_name].setup {
            on_attach = function(client, bufnr)
                -- キーバインドの設定など
            end,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end,
}

require('csvview').setup()
require 'colorizer'.setup()

require("bufferline").setup{}



require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,              -- false にするとハイライトを無効にします
        additional_vim_regex_highlighting = false,
        disable = { "html" },           -- HTMLに対して無効化
    },
    ensure_installed = { "go", "rust" },      -- go パーサーの自動インストール
    indent = {
        enable = true,              -- インデント機能の有効化
    },

    -- textobject
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
        },
    },

    -- refacter
    refactor = {
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },
    },

    -- playground
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },

}

require('neoscroll').setup()

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


local sidebar = require("sidebar-nvim")
local opts = {open = false}
sidebar.setup(opts)

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


require('nvim-test').setup({
    mappings = {
        nearest = '<leader>dt',  -- 現在のカーソル位置に最も近いテストを実行
        file = '<leader>dT',     -- 現在のファイルのテストを実行
        suite = '<leader>da',    -- すべてのテストを実行
        last = '<leader>dl',     -- 最後に実行したテストを再実行
        visit = '<leader>df',    -- 最後に実行したテストのファイルを開く
    }
})


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


vim.g.matchup_matchparen_offscreen = { method = 'popup' }

require('alpha').setup(require('alpha.themes.startify').config)

--
local function file_path()
    return vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.')
end

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
        lualine_c = { file_path },  -- カスタムコンポーネントを使用
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { file_path },  -- カスタムコンポーネントを使用
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

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


require("cyberdream").setup({
    -- 背景を透明にするかどうかを有効化
    transparent = false,

    -- コメントをイタリックにするかどうかを有効化
    italic_comments = true,

    -- 究極のクリーンな外観のために全ての fillchars を ' ' に置き換える
    hide_fillchars = false,

    -- モダンなボーダーレステレスコープテーマ - fzf-luaにも適用
    borderless_telescope = false,

    -- `:terminal` で使用されるターミナルカラーを設定
    terminal_colors = true,

    -- ハイライトをキャッシュして起動時間を改善。`:CyberdreamBuildCache` でキャッシュを生成し、`:CyberdreamClearCache` でクリア
    cache = true,

})


local hlslens = require('hlslens')
if hlslens then
    local overrideLens = function(render, posList, nearest, idx, relIdx)
        local _ = relIdx
        local lnum, col = unpack(posList[idx])

        local text, chunks
        if nearest then
            text = ('[%d/%d]'):format(idx, #posList)
            chunks = {{' ', 'Ignore'}, {text, 'VM_Extend'}}
        else
            text = ('[%d]'):format(idx)
            chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end
    local lensBak
    local config = require('hlslens.config')
    local gid = vim.api.nvim_create_augroup('VMlens', {})
    vim.api.nvim_create_autocmd('User', {
        pattern = {'visual_multi_start', 'visual_multi_exit'},
        group = gid,
        callback = function(ev)
            if ev.match == 'visual_multi_start' then
                lensBak = config.override_lens
                config.override_lens = overrideLens
            else
                config.override_lens = lensBak
            end
            hlslens.start()
        end
    })
end

require("bigfile").setup {
    -- detect long python files
    pattern = function(bufnr, filesize_mib)
        -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
        local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
        local file_length = #file_contents
        if file_length >= 10000 then
            return true
        end
    end
}

-- dap setting start

require('dap-python').setup("/home/linuxbrew/.linuxbrew/bin/python3")


require("dapui").setup({
  icons = { expanded = "", collapsed = "" },
  layouts = {
    {
      elements = {
        { id = "watches", size = 0.20 },
        { id = "stacks", size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "scopes", size = 0.40 },
      },
      size = 64,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.20,
      position = "bottom",
    },
  },
})
