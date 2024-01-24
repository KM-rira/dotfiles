
-- Packer.nvimの初期化と設定
require('packer').startup(function(use)
    -- Packerを管理するために必要
    use 'wbthomason/packer.nvim'

    -- ここからプラグインのリスト
    use 'preservim/nerdtree'
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use 'vim-jp/vimdoc-ja'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'ctrlpvim/ctrlp.vim'
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'joshdick/onedark.vim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'mattn/vim-goimports'
    use {'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-frecency.nvim'}}
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npx --yes yarn install'}
    use 'RRethy/vim-illuminate'
    use 'goolord/alpha-nvim'
    use 'petertriho/nvim-scrollbar'
    use 'jsborjesson/vim-uppercase-sql'
    use 'lewis6991/gitsigns.nvim'
    use 'akinsho/git-conflict.nvim'
    use 'klen/nvim-test'
    use 'numToStr/Comment.nvim'
    use 'sidebar-nvim/sidebar.nvim'
    use {'akinsho/toggleterm.nvim', tag = '*'}
    use 'wfxr/minimap.vim'
    use 'gorbit99/codewindow.nvim'
    use 'karb94/neoscroll.nvim'
    --use 'Aasim-A/scroll.nvim'
    use 'utilyre/barbecue.nvim'
    use 'hotoolong/translate.nvim'
    use {'akinsho/bufferline.nvim', tag = '*'}

    use {
        'folke/todo-comments.nvim',
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


require("bufferline").setup{}


require'treesitter-context'.setup {
    -- ここにオプションを設定
    enable = true,  -- デフォルトで有効にする
    throttle = true, -- スムーズなスクロールのためのスロットル
    max_lines = 0,  -- コンテキストを表示する最大行数（0は無制限）
    patterns = {    -- 表示するノードのタイプ
        -- デフォルトの言語は以下のように設定されています
        default = {
            'class',
            'function',
            'method',
            -- 他に表示したいノードタイプがあればここに追加
        },
        -- 特定の言語のためのカスタム設定も可能
        -- 例：python = { 'class', 'function', 'async_function' },
        go = {
            'function',
            'method',
            -- Go言語に特有の他のノードタイプが必要な場合はここに追加
        },
    },
}


require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,              -- false にするとハイライトを無効にします
        additional_vim_regex_highlighting = false,
    },
    ensure_installed = "go",      -- go パーサーの自動インストール
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

--require('scrollEOF').setup()
--lua require('nvim-ultivisual').setup()
require('neoscroll').setup()

require('codewindow').setup()

-- ミニマップの自動表示
--let g:minimap_auto_start = 1
-- ミニマップの自動トグル
--let g:minimap_auto_toggle = 1

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

--
-- require("nvim-autopairs").setup {}
--

vim.g.matchup_matchparen_offscreen = { method = 'popup' }


require('scrollbar').setup()


require('alpha').setup(require('alpha.themes.startify').config)

--
-- require 'colorizer'.setup(
--   {'*';},          -- すべてのファイルタイプで有効にする
--   {
--     RGB      = true;         -- #RGB 形式を有効にする
--     RRGGBB   = true;         -- #RRGGBB 形式を有効にする
--     names    = true;         -- "blue" のような名前付きカラーを有効にする
--     RRGGBBAA = true;         -- #RRGGBBAA 形式を有効にする
--     rgb_fn   = true;         -- css rgb() および rgba() 関数を有効にする
--     hsl_fn   = true;         -- css hsl() および hsla() 関数を有効にする
--     css      = true;         -- css #RRGGBB 形式を有効にする
--     css_fn   = true;         -- css 関数を有効にする
--   }
-- )
--

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

--
-- -- shortcut
-- local function map(mode, lhs, rhs, opts)
-- 	local options = {noremap = true}
--     if opts then options = vim.tbl_extend('force', options, opts) end
--     vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end
--
-- map("n", "<F5>", ":lua require'dap'.continue()<CR>", { silent = true})
-- map("n", "<F10>", ":lua require'dap'.step_over()<CR>", { silent = true})
-- map("n", "<F11>", ":lua require'dap'.step_into()<CR>", { silent = true})
-- map("n", "<F12>", ":lua require'dap'.step_out()<CR>", { silent = true})
-- map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true})
-- map("n", "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true})
-- map("n", "<leader>l", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { silent = true})
--
-- -- dap-ui key map
-- map("n", "<leader>d", ":lua require'dapui'.toggle()<CR>", { silent = true})
-- map("n", "<leader><leader>df", ":lua require'dapui'.eval()<CR>", { silent = true})
--
-- -- dap-go key map
-- map("n", "<leader>td", ":lua require'dap-go'.debug_test()<CR>", { silent = true })
--
-- -- nvim-dap の基本設定
-- local dap = require("dap")
-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = {'dap', '-l', '127.0.0.1:${port}'},
--   }
-- }
--
-- -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}"
--   },
--   {
--     type = "delve",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     mode = "test",
--     program = "${file}"
--   },
--   -- works with go.mod packages and sub packages
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}"
--   }
-- }
--
--
--
--
-- -- nvim-dap-ui のUI設定
-- require('dapui').setup({
--   icons = { expanded = "▾", collapsed = "▸" },
--   mappings = {
--     -- カスタムキーマッピング
--   },
--   layouts = {
--     {
--       elements = {
--         -- サイドバーのレイアウト設定
--       },
--       size = 40,
--       position = 'left'
--     },
--     {
--       elements = {
--         -- トレイのレイアウト設定
--       },
--       size = 10,
--       position = 'bottom'
--     },
--   }
-- })
--
--
--
-- -- nvim-dap-go の設定
-- require('dap-go').setup()
--
-- local dap = require('dap')
--
-- dap.configurations.lua = {
--   {
--     type = 'nlua',
--     request = 'attach',
--     name = "Attach to running Neovim instance",
--     host = function()
--       return '127.0.0.1'
--     end,
--     port = function()
--       local val = vim.fn.input('Port: ')
--       return tonumber(val)
--     end
--   }
-- }
--
--



-- 補完表示時のEnterで改行をしない
--vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.pumvisible() ? "<C-y>" : "<CR>"', {expr = true, noremap = true})


-- 補完ナビゲーション
--vim.api.nvim_set_keymap('i', '<C-n>', 'v:lua.pumvisible() ? "<Down>" : "<C-n>"', {expr = true, noremap = true})
--vim.api.nvim_set_keymap('i', '<C-p>', 'v:lua.pumvisible() ? "<Up>" : "<C-p>"', {expr = true, noremap = true})





