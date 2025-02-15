#!/usr/bin/env lua

local lfs = require("lfs")
local argparse = require("argparse")

-- argparse パーサーの設定
local parser = argparse("script", "ディレクトリ内の通常ファイルを取得するスクリプト")
parser:flag("-a", "隠しファイル以外のみを取得するオプション")
local args = parser:parse()

local current_dir = "."
local files = {}

-- カレントディレクトリ内の通常ファイルを取得
if args.a then
	-- -a オプションが指定された場合: 隠しファイルを含めて取得
	for file in lfs.dir(current_dir) do
		local fullpath = current_dir .. "/" .. file
		local attr = lfs.attributes(fullpath)
		if attr and attr.mode == "file" then
			table.insert(files, file)
		end
	end
else
	-- オプションが指定されていない場合: 隠しファイルを除外して取得
	for file in lfs.dir(current_dir) do
		if file:sub(1, 1) ~= "." then -- 隠しファイルを除外
			local fullpath = current_dir .. "/" .. file
			local attr = lfs.attributes(fullpath)
			if attr and attr.mode == "file" then
				table.insert(files, file)
			end
		end
	end
end

if #files == 0 then
	print("===== NOT EXIST FILE =====")
	os.exit()
end

-- ファイル一覧を改行区切りの文字列に変換
local list = table.concat(files, "\n")
-- シングルクォートをエスケープ
local escaped_list = list:gsub("'", "'\\''")

-- fzf を呼び出して、エスケープされたファイル一覧をパイプで渡す
local fzf_cmd = "echo '"
	.. escaped_list
	.. "' | fzf --tac --no-sort --reverse --prompt='Select FILE: ' --no-multi --height 70% --layout reverse --info inline --border --preview 'bat --color=always {}' --preview-window '~3'      --bind 'ctrl-/:change-preview-window(50%|hidden|)'"
local fzf_handle = io.popen(fzf_cmd)
local selected = fzf_handle:read("*a") or ""
fzf_handle:close()

-- 選択結果の前後の空白を削除
selected = selected:gsub("^%s*(.-)%s*$", "%1")

if selected == "" then
	print("===== EXIT PROCESS =====")
else
	os.execute("bat " .. selected)
end
