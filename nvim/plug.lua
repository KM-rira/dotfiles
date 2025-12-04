vim.opt.termguicolors = true

-- lazy.nvim を自動インストールするコード
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- stable ブランチを使用
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "KM-rira/myplugin" },
    { "preservim/nerdtree", cmd = "NERDTreeToggle" }, -- NERDTree をコマンドで読み込み
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        tag = "v1.8.0",
        cmd = "NvimTreeToggle",
    },
    { "vim-jp/vimdoc-ja",          event = "VeryLazy" },
    { "nvim-lualine/lualine.nvim", event = "VeryLazy" }, -- 起動後に遅延読み込み
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufRead", "BufNewFile" },
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", event = { "BufRead", "BufNewFile" } },
    { "nvim-treesitter/playground",                  cmd = "TSPlaygroundToggle" },
    { "nvim-treesitter/nvim-treesitter-refactor",    event = { "BufRead", "BufNewFile" } },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-frecency.nvim" },
    },
    { "iamcco/markdown-preview.nvim",  build = "cd app && npx --yes yarn install", ft = "markdown" },
    { "RRethy/vim-illuminate",         event = "BufReadPost" },
    { "goolord/alpha-nvim",            event = "VimEnter" }, -- 起動時に表示
    { "jsborjesson/vim-uppercase-sql", ft = "sql" },
    { "lewis6991/gitsigns.nvim",       event = { "BufRead", "BufNewFile" } },
    { "akinsho/git-conflict.nvim",     tag = "v1.3.0",                             event = "BufReadPost" },
    { "klen/nvim-test",                tag = "1.4.1",                              cmd = "TestNearest" },
    { "numToStr/Comment.nvim",         keys = { "gc", "gcc" } },
    { "sidebar-nvim/sidebar.nvim",     cmd = "SidebarNvimToggle" },
    { "akinsho/toggleterm.nvim",       tag = "v2.11.0",                            cmd = { "ToggleTerm", "TermExec" } },
    -- { "karb94/neoscroll.nvim",         event = "WinScrolled" },
    { "akinsho/bufferline.nvim",       tag = "v4.6.1",                             event = "BufRead" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    --{ "scottmckendry/cyberdream.nvim", lazy = false }, -- 常時ロード
    { "ellisonleao/gruvbox.nvim", lazy = false }, -- 常時ロード
    --{ "joshdick/onedark.vim", lazy = false }, -- 常時ロード
    { "kdheepak/lazygit.nvim",    cmd = "LazyGit" },
    { "github/copilot.vim",       event = "InsertEnter" },
    { "hat0uma/csvview.nvim",     ft = "csv" },
    {
        "Kasama/nvim-custom-diagnostic-highlight",
        config = function()
            require("nvim-custom-diagnostic-highlight").setup({})
        end,
        event = "BufReadPost",
    },
    { "LunarVim/bigfile.nvim",             event = "BufReadPre" },
    { "kevinhwang91/nvim-hlslens",         event = "BufReadPost" },
    { "mg979/vim-visual-multi",            keys = { "<C-n>", "<C-p>" } },
    { "norcalli/nvim-colorizer.lua",       cmd = "ColorizerToggle" },
    { "yamatsum/nvim-cursorline",          event = "BufReadPost" },
    { "sindrets/diffview.nvim",            cmd = { "DiffviewOpen", "DiffviewClose" } },
    { "neovim/nvim-lspconfig",             event = "BufReadPre" },
    { "hrsh7th/nvim-cmp",                  event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp",              event = "InsertEnter" },
    { "L3MON4D3/LuaSnip",                  event = "InsertEnter" },
    { "saadparwaiz1/cmp_luasnip",          event = "InsertEnter" },
    { "rafamadriz/friendly-snippets",      leazy = true },
    { "williamboman/mason.nvim",           cmd = "Mason" },
    { "williamboman/mason-lspconfig.nvim", lazy = true },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cmd = "MasonToolsInstall",
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
    },
    { "mfussenegger/nvim-dap",        cmd = { "DapContinue", "DapToggleBreakpoint" } },
    { "rcarriga/nvim-dap-ui",         dependencies = { "mfussenegger/nvim-dap" },    lazy = true },
    { "mfussenegger/nvim-dap-python", ft = "python" },
    { "nvim-neotest/nvim-nio",        lazy = true },
    {
        "KM-rira/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup({})
        end,
        event = "BufReadPost",
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        event = "BufReadPost",
    },
    {
        "aklt/plantuml-syntax",
        ft = { "plantuml" },
        event = "BufReadPost",
    },
    {
    "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  config = function()
    local leap = require("leap")

    leap.add_default_mappings()

    -- 見やすくて現代的なオプション
    leap.opts.highlight_unlabeled_phase_one_targets = true
    leap.opts.max_phase_one_targets = 0
    leap.opts.labels = "arstneioqwfpbdluyghjkl"
  end,
    },
        event = "BufReadPost",
{
  "tyru/open-browser.vim",
  config = function()
    vim.keymap.set("n", "gx", "<Plug>(openbrowser-open)", { silent = true })
  end,
},


})

-- LuaSnipをロード
local luasnip = require("luasnip")

-- friendly-snippetsからスニペットを読み込む
require("luasnip.loaders.from_vscode").lazy_load()

-- オートコンプリートの設定
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- LuaSnipを使用してスニペットを展開
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- 確定
        ["<C-j>"] = cmp.mapping.select_next_item(),         -- 次の補完候補を選択
        ["<C-k>"] = cmp.mapping.select_prev_item(),         -- 前の補完候補を選択
        -- LuaSnip 用のマッピング
        ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- LuaSnipをソースとして追加
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

-- 共通の on_attach 関数を定義
local on_attach = function(client, bufnr)
    -- バッファローカルのキー設定を容易にするためのショートカット
    local opts = { noremap = true, silent = true, buffer = bufnr }

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

require("csvview").setup()
require("colorizer").setup()

require("bufferline").setup({})

-- require("neoscroll").setup()

local Terminal = require("toggleterm.terminal").Terminal

-- Horizontal terminal
local horizontal_term = Terminal:new({
  direction = "horizontal",
  size = 20,  -- あなたの今の設定と統合
})

vim.keymap.set("n", "<C-t>", function()
  horizontal_term:toggle()
end, { noremap = true, silent = true })

-- -- Vertical terminal（幅をデフォルトより広くする）
-- local vertical_term = Terminal:new({
--   direction = "vertical",
--   size = 110, -- ★ みんな使ってる標準的な幅
-- -- :vertical resize +20
-- })
--
-- vim.keymap.set("n", "<C-t>v", function()
--   vertical_term:toggle()
-- end, { noremap = true, silent = true })

local sidebar = require("sidebar-nvim")
local opts = { open = false }
sidebar.setup(opts)

require("Comment").setup({
    ---コメントと行の間にスペースを追加
    padding = true,
    ---カーソルがその位置に留まるべきかどうか
    sticky = true,
    ---コメントの追加/削除時に無視する行
    ignore = nil,
    ---NORMALモードでのトグルマッピングの左側
    toggler = {
        ---行コメントのトグルキーマップ
        line = "gcc",
        ---ブロックコメントのトグルキーマップ
        block = "gbc",
    },
    ---NORMALおよびVISUALモードでの操作待ちマッピングの左側
    opleader = {
        ---行コメントのキーマップ
        line = "gc",
        ---ブロックコメントのキーマップ
        block = "gb",
    },
    ---追加のマッピングの左側
    extra = {
        ---上の行にコメントを追加
        above = "gcO",
        ---下の行にコメントを追加
        below = "gco",
        ---行の末尾にコメントを追加
        eol = "gcA",
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

require("nvim-test").setup({
    mappings = {
        nearest = "<leader>dt", -- 現在のカーソル位置に最も近いテストを実行
        file = "<leader>dT",    -- 現在のファイルのテストを実行
        suite = "<leader>da",   -- すべてのテストを実行
        last = "<leader>dl",    -- 最後に実行したテストを再実行
        visit = "<leader>df",   -- 最後に実行したテストのファイルを開く
    },
})

require("git-conflict").setup({
    default_mappings = true,     -- disable buffer local mapping created by this plugin
    default_commands = true,     -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = "copen",       -- command or function to open the conflicts list
    highlights = {               -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
    },
})

require("gitsigns").setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,  -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    -- yadm = {
    --     enable = false,
    -- },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- キーマッピングを定義するためのヘルパー関数
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr -- このバッファに限定したキーマッピングにする
            vim.keymap.set(mode, l, r, opts)
        end

        -- =======================================================
        -- gitsigns start
        -- =======================================================

        -- ======================================
        -- Navigation（ナビゲーション）
        -- ======================================
        -- ノーマルモードで ]c を押すと、次の hunk へ移動します
        map("n", "<leader>hn", function()
            if vim.wo.diff then
                -- diffモードの場合はデフォルトの動作を使う
                return "<leader>hn"
            end
            -- hunk移動をスケジュール実行
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        -- ノーマルモードで [c を押すと、前の hunk へ移動します
        map("n", "<leader>hN", function()
            if vim.wo.diff then
                -- diffモードの場合はデフォルトの動作を使う
                return "<leader>hN"
            end
            -- hunk移動をスケジュール実行
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        -- ======================================
        -- Actions（アクション操作）
        -- ======================================
        -- ノーマルモードで <leader>hs を押すと、現在の hunk をステージします
        map("n", "<leader>hs", gs.stage_hunk)
        -- ノーマルモードで <leader>hr を押すと、現在の hunk の変更をリセット（unstage）します
        map("n", "<leader>hr", gs.reset_hunk)

        -- ビジュアルモードで <leader>hs を押すと、選択範囲内の行に対応する hunk をステージします
        map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        -- ビジュアルモードで <leader>hr を押すと、選択範囲内の行に対応する hunk の変更をリセットします
        map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        -- ノーマルモードで <leader>hS を押すと、現在のバッファ全体の変更をステージします
        map("n", "<leader>hS", gs.stage_buffer)
        -- ノーマルモードで <leader>hu を押すと、最後にステージした hunk の操作を取り消します（undo）
        map("n", "<leader>hu", gs.undo_stage_hunk)
        -- ノーマルモードで <leader>hR を押すと、現在のバッファ全体の変更をリセット（unstage）します
        map("n", "<leader>hR", gs.reset_buffer)
        -- ノーマルモードで <leader>hp を押すと、現在の hunk の差分をプレビュー表示します
        map("n", "<leader>hp", gs.preview_hunk)
        -- ノーマルモードで <leader>hb を押すと、現在行の blame 情報を詳細表示（full = true）で表示します
        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end)
        -- ノーマルモードで <leader>tb を押すと、現在行の blame 表示のオン/オフを切り替えます
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        -- ノーマルモードで <leader>hd を押すと、現在の hunk と diff 比較を行います
        map("n", "<leader>hd", gs.diffthis)
        -- ノーマルモードで <leader>hD を押すと、ホームディレクトリとの diff 比較を行います
        map("n", "<leader>hD", function()
            gs.diffthis("~")
        end)
        -- ノーマルモードで <leader>td を押すと、削除された行の表示を切り替えます
        map("n", "<leader>td", gs.toggle_deleted)

        -- ======================================
        -- Text object（テキストオブジェクト）
        -- ======================================
        -- オペレーター待機モード（"o" と "x"）で ih を押すと、hunk 全体を選択します
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

        -- =======================================================
        -- gitsigns end
        -- =======================================================
    end,
})

-- require("gitsigns").setup({
--     signs = {
--         add = { text = "│" },
--         change = { text = "│" },
--         delete = { text = "_" },
--         topdelete = { text = "‾" },
--         changedelete = { text = "~" },
--         untracked = { text = "┆" },
--     },
--     signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
--     numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
--     linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
--     word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
--     watch_gitdir = {
--         follow_files = true,
--     },
--     auto_attach = true,
--     attach_to_untracked = true,
--     current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
--     current_line_blame_opts = {
--         virt_text = true,
--         virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
--         delay = 1000,
--         ignore_whitespace = false,
--         virt_text_priority = 100,
--     },
--     current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
--     sign_priority = 6,
--     update_debounce = 100,
--     status_formatter = nil, -- Use default
--     max_file_length = 40000, -- Disable if file is longer than this (in lines)
--     preview_config = {
--         -- Options passed to nvim_open_win
--         border = "single",
--         style = "minimal",
--         relative = "cursor",
--         row = 0,
--         col = 1,
--     },
--     yadm = {
--         enable = false,
--     },
-- })

vim.g.matchup_matchparen_offscreen = { method = "popup" }

require("alpha").setup(require("alpha.themes.startify").config)

--
local function file_path()
    return vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { file_path }, -- カスタムコンポーネントを使用
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { file_path }, -- カスタムコンポーネントを使用
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})

local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },

        -- デフォルトはプレビュー非表示（多くのピッカーが軽くなる）
        preview = {
            hide_on_startup = true,
        },
    },

    pickers = {
        -- ▼ find_files はプレビュー無し（あなたの希望）
        find_files = {
            previewer = false,
        },

        -- ▼ live_grep は上下分割の UI にする
        live_grep = {
            previewer = true,
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.45,   -- プレビュー45%、下に選択リスト55%
                mirror = true,           -- プレビューを上側に配置
            },
        },
    },
})

require("nvim-tree").setup({
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
        },
    },
    -- `BufEnter` でフォーカスされたファイルを更新し、ファイルが見つかるまでフォルダーを再帰的に展開
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    -- システムオープンコマンドの設定（デフォルトではツリー内の `s`）
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
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
        side = "left",
        -- マッピングの設定は個別に行う
    },
})

--require("cyberdream").setup({
-- 背景を透明にするかどうかを有効化
--    transparent = false,

-- コメントをイタリックにするかどうかを有効化
--    italic_comments = true,

-- 究極のクリーンな外観のために全ての fillchars を ' ' に置き換える
--    hide_fillchars = false,

-- モダンなボーダーレステレスコープテーマ - fzf-luaにも適用
--    borderless_telescope = false,

-- `:terminal` で使用されるターミナルカラーを設定
--    terminal_colors = true,

-- ハイライトをキャッシュして起動時間を改善。`:CyberdreamBuildCache` でキャッシュを生成し、`:CyberdreamClearCache` でクリア
--    cache = true,
--})

local hlslens = require("hlslens")
if hlslens then
    local overrideLens = function(render, posList, nearest, idx, relIdx)
        local _ = relIdx
        local lnum, col = unpack(posList[idx])

        local text, chunks
        if nearest then
            text = ("[%d/%d]"):format(idx, #posList)
            chunks = { { " ", "Ignore" }, { text, "VM_Extend" } }
        else
            text = ("[%d]"):format(idx)
            chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end
    local lensBak
    local config = require("hlslens.config")
    local gid = vim.api.nvim_create_augroup("VMlens", {})
    vim.api.nvim_create_autocmd("User", {
        pattern = { "visual_multi_start", "visual_multi_exit" },
        group = gid,
        callback = function(ev)
            if ev.match == "visual_multi_start" then
                lensBak = config.override_lens
                config.override_lens = overrideLens
            else
                config.override_lens = lensBak
            end
            hlslens.start()
        end,
    })
end

require("bigfile").setup({
    -- detect long python files
    pattern = function(bufnr, filesize_mib)
        -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
        local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
        local file_length = #file_contents
        if file_length >= 10000 then
            return true
        end
    end,
})

-- dap setting start
require("dap-python").setup("/home/koji/.config/nvim/venv/bin/python3")

require("dapui").setup({
    icons = { expanded = "", collapsed = "" },
    layouts = {
        {
            elements = {
                { id = "watches",     size = 0.20 },
                { id = "stacks",      size = 0.20 },
                { id = "breakpoints", size = 0.20 },
                { id = "scopes",      size = 0.40 },
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

require("codecompanion").setup({
    strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
    },
    adapters = {
        gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
                schema = {
                    model = { default = "gemini-1.5-flash" },
                },
                system_prompt = {
                    default = "あなたはプロフェッショナルなソフトウェアエンジニアであり、常に日本語でわかりやすく、簡潔に説明や提案を行います。コード例も含めて丁寧に回答してください。",
                },
            })
        end,
    },
})

vim.filetype.add({
    extension = {
        puml = "plantuml",
    },
})

