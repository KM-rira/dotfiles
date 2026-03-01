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
local nvim_lsp = require("lspconfig")
-- 使用するLSPサーバーの設定例（goplsを例に）
nvim_lsp.gopls.setup({
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

-- 他のLSPサーバーも同様に設定
-- 例: pyright
nvim_lsp.pyright.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
})

-- 🌟 ProtoBuf (bufls) の設定を修正 🌟
-- nvim_lsp.bufls.setup({
--     on_attach = on_attach,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     -- ここで bufls バイナリの絶対パスを明示的に指定します
--     cmd = { "/home/linuxbrew/.linuxbrew/bin/buf", "ls" },
-- })

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = mason_lspconfig_list, -- 必要なLSPサーバーを列挙
})

local lspconfig = require("lspconfig")

-- require("mason-lspconfig").setup_handlers({
--     function(server_name)
--         lspconfig[server_name].setup({
--             on_attach = function(client, bufnr)
--                 -- キーバインドの設定など
--             end,
--             flags = {
--                 debounce_text_changes = 150,
--             },
--         })
--     end,
-- })

require("mason-tool-installer").setup({
    ensure_installed = mason_tool_installer_list,
})

require("lspconfig").groovyls.setup({
    cmd = {
        "java",
        "-jar",
        "/Users/s29442/repo/groovy-language-server/build/libs/groovy-language-server-all.jar",
    },
    filetypes = { "groovy" },
    root_dir = require("lspconfig.util").root_pattern(".git", "."),
})

local util = require("lspconfig.util")

lspconfig.ts_ls.setup({
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
