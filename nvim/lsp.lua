-- Description: LSPの設定を行う

vim.schedule(function()
  vim.notify("LSP CONFIG LOADED", vim.log.levels.WARN)
end)

-- LSPの設定
local mason_lspconfig_list = {
    "pyright", -- Python
    "tsserver",   -- TypeScript & JavaScript
    "gopls",   -- Go
    "lua_ls",  -- Lua
    "yamlls",  -- YAML
    "jsonls",  -- JSON
    "bashls",  -- Bash
    "html",    -- HTML
    "cssls",   -- CSS
    "eslint",  -- JavaScript & TypeScript用Lint
    -- "cuelsp",  -- Cuelang
    -- "groovyls",
}

local mason_tool_installer_list = {
    "stylua",   -- Luaフォーマッター
    "luacheck", -- Lua Linter
    "black",    -- Pythonフォーマッター
    -- "gopls",    -- Go LSP
    "shfmt",    -- シェルスクリプトフォーマッター
    "prettier", -- JS, CSS, HTMLのフォーマッター
    "eslint_d", -- JavaScript & TypeScript用のLinter（軽量版）
}

-- LSPの設定を読み込む
-- Neovim 0.11+ uses vim.lsp.config
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

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = mason_lspconfig_list, -- 必要なLSPサーバーを列挙
})

-- mason-lspconfig と vim.lsp.config の連携
require("mason-lspconfig").setup_handlers({
    function(server_name)
        -- ts_ls など個別に設定しているもの以外を自動設定
        if server_name ~= "gopls" and server_name ~= "pyright" and server_name ~= "ts_ls" and server_name ~= "groovyls" then
            vim.lsp.config(server_name, {
                on_attach = on_attach,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        end
    end,
})

require("mason-tool-installer").setup({
    ensure_installed = mason_tool_installer_list,
})

vim.lsp.config("groovyls", {
    cmd = {
        "java",
        "-jar",
        "/Users/s29442/repo/groovy-language-server/build/libs/groovy-language-server-all.jar",
    },
    filetypes = { "groovy" },
    root_dir = require("lspconfig.util").root_pattern(".git", "."),
})

local util = require("lspconfig.util")

vim.lsp.config("ts_ls", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
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
