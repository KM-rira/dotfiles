-- Description: null-ls の設定ファイル
-- 新たにフォーマッタやリンタを追加したい場合は、以下の手順で設定を追加してください。

-- 編集手順
-- 1. null_ls.setup内に対象とする言語のフォーマッタとリンタを追加
-- 2. vim.api.nvim_create_autocmdに自動フォーマットの設定を追加

-- null-ls をロード
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

-- null-ls のビルトインを簡略化
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- フォーマッタとリンタの設定
null_ls.setup({
	sources = {
		-- Python フォーマッタ
		formatting.black, -- Black
		formatting.isort, -- isort（インポートの整列）

		-- Python リンタ
		diagnostics.flake8, -- flake8
		diagnostics.mypy, -- mypy（型チェック）

		-- Go フォーマッタ
		formatting.goimports, -- goimports
		formatting.gofmt,

		-- Go リンタ
		diagnostics.staticcheck,

		-- lua formatter and linter
		-- install "cargo install stylua"
		-- install "luarocks install luacheck"
		formatting.stylua, -- Stylua フォーマッター
		diagnostics.luacheck, -- Luacheck リンタ

		-- Shell スクリプト フォーマッタとリンタ
		formatting.shfmt, -- shfmt （シェルスクリプトの整形）
		diagnostics.shellcheck, -- shellcheck （シェルスクリプトの診断）
	},
})

-- Python ファイル保存時に自動フォーマットを実行
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py", -- Python ファイルに限定
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Go ファイル保存時に自動フォーマットを実行
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go", -- Go ファイルに限定
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- lua ファイル保存時に自動フォーマットを実行
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua" }, -- Lua ファイルを対象とする
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- lua ファイル保存時に自動フォーマットを実行
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.sh" }, -- Lua ファイルを対象とする
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- json ファイル保存時に自動フォーマットを実行
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.json" },
	callback = function()
		-- 現在のビュー状態を保存
		local view = vim.fn.winsaveview()

		-- 現在のバッファ内容を取得
		local buf = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		local input = table.concat(lines, "\n")

		-- jqコマンドを実行して出力を取得
		local output = vim.fn.system("jq .", input)

		-- jq実行後のエラーコードをチェック
		if vim.v.shell_error == 0 then
			-- jqが正常に整形できた場合のみバッファを更新
			local formatted_lines = vim.split(output, "\n")
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted_lines)
		else
			-- エラーがあった場合、通知を表示（オプション）
			vim.notify("jq formatting error:\n" .. output, vim.log.levels.ERROR)
			-- バッファは変更せず、元の状態を保持
		end

		-- 保存前のビュー状態を復元
		vim.fn.winrestview(view)
	end,
})

-- yml ファイル保存時に自動フォーマットを実行
-- go install github.com/mikefarah/yq/v4@latest
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.yaml", "*.yml" },
-- 	callback = function()
-- 		local view = vim.fn.winsaveview()
-- 		vim.cmd("%!yamlfmt -") -- バッファ全体をyamlfmtに渡して整形
-- 		vim.fn.winrestview(view)
-- 	end,
-- })
