#!/usr/bin/env lua

local function vf()
	-- 現在のディレクトリ内の通常ファイルの数を取得
	local count_handle = io.popen("find . -maxdepth 1 -type f | wc -l")
	local file_count_str = count_handle:read("*a")
	count_handle:close()
	local file_count = tonumber(file_count_str:match("(%d+)") or "0")

	if file_count == 0 then
		print("===== NOT EXIST FILE =====")
		return
	end

	-- fzf を用いてファイルを選択
	local fzf_cmd = "find . -maxdepth 1 -type f | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi"
	local select_handle = io.popen(fzf_cmd)
	local select_file = select_handle:read("*a") or ""
	select_handle:close()

	-- 改行や不要な空白を取り除く
	select_file = select_file:gsub("^%s*(.-)%s*$", "%1")

	if select_file == "" then
		print("===== EXIT PROCESS =====")
		return
	end

	-- 選択されたファイルを nvim で開く
	os.execute("nvim " .. select_file)
end

vf()
