 local wezterm = require 'wezterm';
 return {
    default_prog = {"C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i"},
    color_scheme = "YourCustomScheme",
    colors = {
    foreground = "#30D5C8",  -- ターコイズブルー
    background = "#1C1C1C",  -- 暗いグレーの背景
    cursor_bg = "#30D5C8",   -- ターコイズブルーのカーソル
    cursor_border = "#30D5C8",
    cursor_fg = "#1C1C1C",
    selection_bg = "#FFA500", -- 選択時の背景色
    selection_fg = "#FFFFFF",

    -- 以下は通常のANSIカラー
    ansi = {"#2E3436", "#CC0000", "#4E9A06", "#C4A000",
            "#3465A4", "#75507B", "#06989A", "#D3D7CF"},
    brights = {"#555753", "#EF2929", "#8AE234", "#FCE94F",
               "#729FCF", "#AD7FA8", "#34E2E2", "#EEEEEC"},
    },

    keys = {
        -- 次のタブに移動
        {key="Tab", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
        -- 前のタブに移動
        {key="Tab", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},

        {key="v", mods="SUPER", action=wezterm.action{PasteFrom="Clipboard"}},
    },
    audible_bell = "Disabled",audible_bell = "Disabled",
    font_size = 11.0,
 }

