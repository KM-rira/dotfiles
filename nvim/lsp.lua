-- Description: LSPの設定を行う

vim.schedule(function()
    vim.notify("LSP CONFIG LOADED", vim.log.levels.WARN)
end)

-- LSPの設定
local mason_lspconfig_list = {
    "pyright", -- Python
    "ts_ls",   -- 💡 tsserver から ts_ls に名称変更されました
    "gopls",   -- Go
    "lua_ls",  -- Lua
    "yamlls",  -- YAML
    "jsonls",  -- JSON
    "bashls",  -- Bash
    "html",    -- HTML
    "cssls",   -- CSS
    "eslint",  -- JavaScript & TypeScript用Lint
}

local mason_tool_installer_list = {
    "stylua",   -- Luaフォーマッター
    "luacheck", -- Lua Linter
    "black",    -- Pythonフォーマッター
    "shfmt",    -- シェルスクリプトフォーマッター
    "prettier", -- JS, CSS, HTMLのフォーマッター
    "eslint_d", -- JavaScript & TypeScript用のLinter（軽量版）
}

-- Neovim 0.11+ 組み込みの vim.lsp.config を使った各LSPの個別設定

-- goplsの設定
vim.lsp.config("gopls", {
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
})

-- pyrightの設定
vim.lsp.config("pyright", {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
})

-- groovylsの設定
vim.lsp.config("groovyls", {
    cmd = {
        "java",
        "-jar",
        "/Users/s29442/repo/groovy-language-server/build/libs/groovy-language-server-all.jar",
    },
    filetypes = { "groovy" },
    -- 💡 外部プラグインの lspconfig.util に依存しないように nil チェックを挟むか、直接関数を定義するのが安全です
    root_dir = function(filename)
        return vim.fs.root(filename, { ".git", "." })
    end,
})

-- ts_lsの設定
vim.lsp.config("ts_ls", {
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(filename)
        return vim.fs.root(filename, { "tsconfig.json", "package.json", "jsconfig.json", ".git" })
    end,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
            },
        },
    },
})

--
-- Mason 関連の設定と自動セットアップ
--

require("mason").setup()

-- 💡 エラーの原因だった setup_handlers を廃止し、
-- mason-lspconfig の `handlers` オプションに直接自動設定ロジックを統合します。
require("mason-lspconfig").setup({
    ensure_installed = mason_lspconfig_list,
    handlers = {
        -- デフォルトのハンドラ (リストにあるすべてのサーバーに対して自動で実行されます)
        function(server_name)
            -- すでに上で個別に vim.lsp.config を設定済みのものはスキップ
            if server_name ~= "gopls" and server_name ~= "pyright" and server_name ~= "ts_ls" and server_name ~= "groovyls" then
                vim.lsp.config(server_name, {
                    on_attach = on_attach,
                    flags = {
                        debounce_text_changes = 150,
                    },
                })
            end

            -- 💡 Neovim 0.11+ では、設定した config を使ってサーバーを起動（enable）させる必要があります
            vim.lsp.enable(server_name)
        end,
    }
})

require("mason-tool-installer").setup({
    ensure_installed = mason_tool_installer_list,
})
