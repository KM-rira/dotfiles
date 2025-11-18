-- タイマー開始
local start_time = vim.loop.hrtime()

-- ホームディレクトリのパスを取得する関数
local function get_home_directory()
    if os.getenv("HOME") then
        return os.getenv("HOME")
    elseif os.getenv("USERPROFILE") then
        return os.getenv("USERPROFILE")
    else
        return nil
    end
end

-- ホームディレクトリのパスを取得
local home_directory = get_home_directory()

-- ホームディレクトリが見つかった場合のみ、plug.luaを読み込む
if home_directory then
    -- dotfiles/nvimフォルダへのパスを組み立てる
    local nvim_lua_path = home_directory .. "/dotfiles/nvim/?.lua"

    -- package.pathに追加
    package.path = package.path .. ";" .. nvim_lua_path

    -- main.luaを読み込む
    require("main")

     -- require("main") 後の経過時間を計算
    local end_time = vim.loop.hrtime()
    local elapsed_ms = (end_time - start_time) / 1e6
    print(string.format("Neovim start up time: %.2f ms", elapsed_ms))
else
    print("Home directory not found.")
end

