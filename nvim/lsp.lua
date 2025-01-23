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
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "pyright", "tsserver", "gopls", "lua_ls", "yamlls", "jsonls", "bashls" }, -- 必要なLSPサーバーを列挙
})

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = function(client, bufnr)
				-- キーバインドの設定など
			end,
			flags = {
				debounce_text_changes = 150,
			},
		})
	end,
})

require("mason-tool-installer").setup({
	ensure_installed = { "stylua", "luacheck", "black", "gopls", "shfmt" },
})
