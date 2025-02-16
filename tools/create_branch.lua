#!/usr/bin/env lua

local function create_branch(args)
    local local_only = false
    local branch = nil

    -- 引数解析
    for _, arg in ipairs(args) do
        if arg == "-l" then
            local_only = true
        elseif not branch then
            branch = arg
        end
    end

    if not branch then
        print("===== NEED PARAMETER =====")
        os.exit(1)
    end

    -- ブランチ作成
    os.execute("git checkout -b " .. branch)

    -- -l オプションがない場合はリモートにプッシュ
    if not local_only then
        os.execute("git push -u origin " .. branch)
    end
end

-- スクリプトの実行
create_branch(arg)
