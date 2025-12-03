local function run_current_file()
	if vim.bo.buftype ~= "" then
		print("Cannot run this buffer type")
		return
	end

	-- Save the current file
	vim.cmd("write")

	-- Get the current file extension and full path
	local filetype = vim.fn.expand("%:e")
	local fullpath = vim.fn.expand("%:p")

	-- Convert Windows path to Unix style (WSL)
	local unixpath = fullpath:gsub("\\", "/"):gsub("^C:", "/mnt/c")

	-- Run the appropriate command based on the file extension
	if filetype == "py" then
		vim.cmd("!python3 " .. unixpath)
	else
		print("No run command for this file type.")
	end
end

vim.api.nvim_create_user_command("W", run_current_file, {})

-- CRを削除する関数の定義
local function remove_cr()
	vim.cmd("%s/\\r//ge")
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = remove_cr,
})

-- 全置換コマンド
vim.api.nvim_create_user_command("Replace", function(args)
	local argStr = args.args
	-- ダブルクォートで囲まれた2つの文字列を抽出
	local s1, s2 = argStr:match('"([^"]+)"%s+"([^"]+)"')
	if s1 and s2 then
		-- 置換コマンドの実行
		vim.cmd(string.format("%%s/%s/%s/g", vim.fn.escape(s1, "/"), vim.fn.escape(s2, "/")))
	else
		print('Invalid arguments. Use :Replace "search string" "replacement string"')
	end
end, { nargs = 1 })

-- 1か所ずつ置換コマンド
vim.api.nvim_create_user_command("ReplaceOne", function(args)
	local argStr = args.args
	-- ダブルクォートで囲まれた2つの文字列を抽出
	local s1, s2 = argStr:match('"([^"]+)"%s+"([^"]+)"')
	if s1 and s2 then
		-- カーソルの現在位置から末尾までの範囲で置換を実行
		vim.cmd(string.format(".,$s/%s/%s/gc", vim.fn.escape(s1, "/"), vim.fn.escape(s2, "/")))
	else
		print('Invalid arguments. Use :ReplaceOne "search string" "replacement string"')
	end
end, { nargs = 1 })

-- 1か所ずつ置換コマンド(逆検索)
vim.api.nvim_create_user_command("ReplaceOneUp", function(args)
	local argStr = args.args
	-- ダブルクォートで囲まれた2つの文字列を抽出
	local s1, s2 = argStr:match('"([^"]+)"%s+"([^"]+)"')
	if s1 and s2 then
		-- カーソルの現在位置から上に向かって検索し、1か所ずつ置換
		local searchPattern = vim.fn.escape(s1, "/")
		local replaceStr = vim.fn.escape(s2, "/")
	else
		print('Invalid arguments. Use :ReplaceOneUp "search string" "replacement string"')
	end
end, { nargs = 1 })

-- ドルマーク検索
vim.api.nvim_create_user_command("Sd", function()
	local searchPattern = "\\$"
	local result = vim.fn.search(searchPattern)

	if result == 0 then
		print("'$' not found.")
	end
end, {})

-- カスタム検索コマンド
vim.api.nvim_create_user_command("Tg", function(args)
	local arguments = {}
	for word in args.args:gmatch("%S+") do
		table.insert(arguments, word)
	end
	local search_string = arguments[1]
	local file_type = arguments[2]
	if not search_string or not file_type then
		print("Usage: :Tg <search_string> <file_type>")
		return
	end
	vim.cmd("Telescope grep_string search=" .. search_string .. " extensions=" .. file_type)
end, { nargs = "+" })

local function trim_trailing_whitespace()
	local save = vim.fn.winsaveview()
	-- 末尾の全角スペース、半角スペース、タブを削除
	vim.api.nvim_exec([[%s/\v[ \t\u3000]+$//e]], false)
	-- ^M（キャリッジリターン）を削除。エラーを無視するための 'e' フラグを追加
	vim.api.nvim_exec([[%s/\r//ge]], false)
	-- 他の非表示文字の削除（ゼロ幅スペース）
	--vim.api.nvim_exec([[%s/[\x00-\x1F\x7F]//g]], false)
	vim.fn.winrestview(save)
end

vim.api.nvim_create_augroup("TrimWhitespaceOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "TrimWhitespaceOnSave",
	pattern = "*",
	callback = trim_trailing_whitespace,
})

-- -- カスタムコマンド: BufferCloseThis
-- vim.api.nvim_create_user_command('BufferCloseThis', function()
--     -- 現在のバッファ番号を取得
--     local current_buf = vim.api.nvim_get_current_buf()
--
--     -- バッファを強制的に閉じる
--     vim.api.nvim_buf_delete(current_buf, { force = true })
--
--     -- 確認メッセージ（オプション）
--     vim.api.nvim_echo({{"Buffer " .. current_buf .. " has been closed.", "Normal"}}, false, {})
-- end, { desc = "Force close the current buffer" })
--
-- BufferCloseThis コマンドの定義
vim.api.nvim_create_user_command("BufferCloseThis", function()
	local current_buf = vim.api.nvim_get_current_buf()
	local buf_name = vim.api.nvim_buf_get_name(current_buf)

	if buf_name == "" then
		buf_name = "[No Name]"
	else
		buf_name = vim.fn.fnamemodify(buf_name, ":t")
	end

	local success, err = pcall(vim.api.nvim_buf_delete, current_buf, { force = true })

	if success then
		vim.api.nvim_echo(
			{ { buf_name .. " has been closed. (BufferID: " .. current_buf .. ")", "Normal" } },
			false,
			{}
		)
	else
		vim.api.nvim_echo({ { "Error closing buffer: " .. err, "ErrorMsg" } }, false, {})
	end
end, { desc = "Force close the current buffer" })

-- キーバインド: <leader>bc で BufferCloseThis を実行
vim.api.nvim_set_keymap(
	"n",
	"<leader>bc",
	":BufferCloseThis<CR>",
	{ noremap = true, silent = true, desc = "Force close the current buffer" }
)

-- 現在のカーソル行の真ん中にカーソルを移動する関数
function CenterCursorOnLine()
	-- 現在の行番号を取得
	local current_line = vim.api.nvim_get_current_line()

	-- 行の文字列の長さを計算
	local line_length = #current_line

	-- 中央の位置を計算（Luaは1-based indexなので、+1を加える）
	local middle_pos = math.floor(line_length / 2) + 1

	-- 現在のカーソル位置を取得
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

	-- カーソルを中央に移動
	vim.api.nvim_win_set_cursor(0, { row, middle_pos - 1 }) -- カラムは0-based
end

-- SelectionRange
vim.api.nvim_create_user_command("Sr", function()
	local mode = vim.fn.mode()
	local start_line, end_line

	if mode == "v" or mode == "V" then
		-- Visualモードで選択された範囲を取得
		start_line = vim.fn.line("v")
		end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end

		-- 選択解除（正常に終了）
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	else
		-- ノーマルモード: 現在行のみ
		start_line = vim.fn.line(".")
		end_line = start_line
	end

	local abs_path = vim.fn.expand("%:p")
	local rel_path = vim.fn.fnamemodify(abs_path, ":.")

	local output = string.format("%s L%d-%d", rel_path, start_line, end_line)

	vim.fn.setreg('"', output)
	vim.fn.setreg("+", output)

	print(output)
end, {})

-- SelectionFile
vim.api.nvim_create_user_command("Sf", function()
	local abs_path = vim.fn.expand("%:p")
	local rel_path = vim.fn.fnamemodify(abs_path, ":.")

	local output = rel_path

	vim.fn.setreg('"', output)
	vim.fn.setreg("+", output)

	vim.api.nvim_create_user_command("OpenSVG", function()
		local file = vim.fn.expand("%:p")
		if not file:match("%.svg$") then
			print("This is not an SVG file.")
			return
		end

		local open_cmd
		if vim.fn.has("mac") == 1 then
			open_cmd = "open"
		elseif vim.fn.has("unix") == 1 then
			open_cmd = "xdg-open"
		elseif vim.fn.has("win32") == 1 then
			open_cmd = "start"
		else
			print("Unsupported OS")
			return
		end

		vim.fn.jobstart({ open_cmd, file }, { detach = true })
	end, {})
	print(output)
end, {})

vim.api.nvim_create_user_command("Tf", function(opts)
  local args = vim.split(opts.args, "%s+")
  local search_hidden = false
  local filetype = nil

  -- --- 引数パース ---
  for i = 1, #args do
    local arg = args[i]

    if arg == "-a" then
      search_hidden = true

    elseif arg == "-t" then
      filetype = args[i + 1]
    end
  end

  -- rg コマンド構築
  local find_command = { "rg", "--files" }

  -- hidden OFF（デフォルト） → dotfile 除外
  if not search_hidden then
    table.insert(find_command, "--glob")
    table.insert(find_command, "!.*")  -- dotfile 全除外
  end

  -- hidden ON
  if search_hidden then
    table.insert(find_command, "--hidden")
    table.insert(find_command, "--glob")
    table.insert(find_command, "!.git/*")  -- .gitだけ除外
  end

  -- 拡張子指定（*.go など）
  if filetype then
    table.insert(find_command, "--glob")
    table.insert(find_command, string.format("*.%s", filetype))
  end

  require("telescope.builtin").find_files({
    find_command = find_command,
  })
end, {
  nargs = "*",
})

vim.api.nvim_create_user_command("Tg", function(opts)
  local args = vim.split(opts.args, "%s+")
  local search_hidden = false
  local filetype = nil
  local query = nil

  local i = 1
  while i <= #args do
    local arg = args[i]

    if arg == "-a" then
      search_hidden = true

    elseif arg == "-t" then
      filetype = args[i + 1]
      i = i + 1

    else
      -- 最初に出てきた非オプションは検索ワード
      if not query then
        query = arg
      end
    end

    i = i + 1
  end

  if not query or query == "" then
    print("Tg: 検索ワードを指定してください")
    return
  end

  -- grep オプション構築
  local extra = {}

  if not search_hidden then
    table.insert(extra, "--glob")
    table.insert(extra, "!.*")
  else
    table.insert(extra, "--hidden")
    table.insert(extra, "--glob")
    table.insert(extra, "!.git/*")
  end

  if filetype then
    table.insert(extra, "--glob")
    table.insert(extra, string.format("*.%s", filetype))
  end

  require("telescope.builtin").live_grep({
    default_text = query,
    additional_args = function()
      return extra
    end,
  })
end, {
  nargs = "*",
})

-- ステータスライン toggle 用の関数
local function toggle_statusline()
  if vim.o.laststatus == 0 then
    vim.o.laststatus = 3   -- 表示（全体で1つのステータスライン）
  else
    vim.o.laststatus = 0   -- 非表示
  end
end

-- Ctrl-s を押すとトグル
vim.keymap.set("n", "<C-s>", toggle_statusline, { noremap = true, silent = true })

vim.api.nvim_create_user_command("Fullpath", function()
  local fullpath = vim.fn.expand("%:p")
  vim.fn.setreg("+", fullpath)   -- システムクリップボードへコピー
  print("Copied to clipboard: " .. fullpath)
end, {})

vim.api.nvim_create_user_command("Lg", function()
  vim.cmd("LazyGit")
end, {})

-- 共通処理：bool トグルできたら true を返す
local function toggle_boolean_if_possible()
  local word = vim.fn.expand("<cword>")
  if word == "true" then
    vim.cmd("normal! ciwfalse")
    return true
  elseif word == "false" then
    vim.cmd("normal! ciwtrue")
    return true
  end
  return false
end

-- 共通処理：<C-a> または <C-x> の元の動作を呼び出す
local function feed_ctrl(key)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(key, true, false, true),
    "n",
    false
  )
end

-- スマート Ctrl+A / Ctrl+X 共通化された本体
local function smart_ctrl(op)
  -- トグルできたら終了
  if toggle_boolean_if_possible() then return end

  -- トグルできなければ本来の動作を実行
  if op == "inc" then
    feed_ctrl("<C-a>")
  else
    feed_ctrl("<C-x>")
  end
end

-- Normal / Insert mode
vim.keymap.set({"n", "i"}, "<C-a>", function() smart_ctrl("inc") end, { noremap = true, silent = true })
vim.keymap.set({"n", "i"}, "<C-x>", function() smart_ctrl("dec") end, { noremap = true, silent = true })


