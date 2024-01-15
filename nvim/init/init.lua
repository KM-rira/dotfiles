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
    -- vimConf/nvimフォルダへのパスを組み立てる
    local nvim_lua_path = home_directory .. "/vimConf/nvim/?.lua"

    -- package.pathに追加
    package.path = package.path .. ";" .. nvim_lua_path

    -- main.luaを読み込む
    require("main")
else
    print("Home directory not found.")
end

