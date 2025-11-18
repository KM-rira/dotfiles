local wezterm = require("wezterm")
local act = wezterm.action
return {
	default_prog = { "wsl.exe" },
	-- default_prog = {"C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i"},
	font_size = 11.0,
	color_scheme = "YourCustomScheme",
	colors = {
		foreground = "#eee8aa",
		background = "#121212",
		cursor_bg = "#f0246b",
		cursor_border = "#f0246b",
		cursor_fg = "#000000",
		selection_bg = "#FFA500",
		selection_fg = "#000000",
		ansi = { "#2E3436", "#CC0000", "#4E9A06", "#C4A000", "#3465A4", "#75507B", "#06989A", "#D3D7CF" },
		brights = { "#555753", "#EF2929", "#8AE234", "#FCE94F", "#729FCF", "#AD7FA8", "#34E2E2", "#EEEEEC" },
	},
	keys = {
		{
			key = "c",
			mods = "ALT",
			action = wezterm.action.SendKey({
				key = "c",
				mods = "CTRL",
			}),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnCommandInNewTab({
				args = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i" },
			}),
		},
		{
			key = "g",
			mods = "ALT",
			action = act.ScrollToTop,
		},
		-- Scroll to bottom with ALT+SHIFT+G                                        │
		{
			key = "g",
			mods = "SHIFT|ALT",
			action = act.ScrollToBottom,
		},
		-- 次のタブに移動
		{ key = "Tab", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
		-- 前のタブに移動
		{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
		-- windowキー無効化
		-- {key="v", mods="SUPER", action="Nop"},
		-- 1ページ上にスクロール
		{ key = "b", mods = "ALT", action = wezterm.action({ ScrollByPage = -1 }) },
		-- 1ページ下にスクロール
		{ key = "f", mods = "ALT", action = wezterm.action({ ScrollByPage = 1 }) },
		-- 半ページを下にスクロール
		{ key = "d", mods = "ALT", action = wezterm.action({ ScrollByPage = -0.5 }) },
		-- 半ページを上にスクロール
		{ key = "u", mods = "ALT", action = wezterm.action({ ScrollByPage = 0.5 }) },
		-- 一行上にスクロール
		{ key = "k", mods = "SHIFT|ALT", action = wezterm.action({ ScrollByLine = -1 }) },
		-- 一行下にスクロール
		{ key = "j", mods = "SHIFT|ALT", action = wezterm.action({ ScrollByLine = 1 }) },
		-- ペインを垂直分割
		{
			key = "v",
			mods = "SHIFT|ALT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		-- ペインを水平分割
		{
			key = "s",
			mods = "SHIFT|ALT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		-- タブを左に移動
		{ key = "<", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
		-- タブを右に移動
		{ key = ">", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
		-- 次のペインへ移動
		{ key = "l", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		-- 前のペインへ移動
		{ key = "h", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		-- 上下のペイン間を移動するための追加のショートカット
		{ key = "j", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		-- 矢印キーを使用してペインのサイズを調整
		{ key = "RightArrow", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
		{ key = "LeftArrow", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "DownArrow", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "UpArrow", mods = "SHIFT|ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
		-- アクティブなペインを閉じる
		{ key = "w", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		-- 文字の大きさを増やす
		{ key = "+", mods = "SHIFT|ALT", action = "IncreaseFontSize" },
		-- 文字の大きさを減らす
		{ key = "=", mods = "SHIFT|ALT", action = "DecreaseFontSize" },
		-- 文字の大きさをリセット
		{ key = "0", mods = "SHIFT|ALT", action = "ResetFontSize" },
		{ key = "x", mods = "SHIFT|CTRL", action = wezterm.action.QuickSelect },
		{
			key = "c",
			mods = "CTRL",
			action = wezterm.action({ CopyTo = "Clipboard" }),
		},
		{
			key = "v",
			mods = "CTRL",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		-- Ctrl + Shift + C/V を無効化
		{
			key = "C",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SendKey({ key = "c", mods = "CTRL" }),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action.Nop,
		},
		{
			key = "M",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivateCopyMode,
		},
	},
	audible_bell = "Disabled",
	font_size = 7.7,

	key_tables = {
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "Tab",
				mods = "SHIFT",
				action = act.CopyMode("MoveBackwardWord"),
			},
			{
				key = "Enter",
				mods = "NONE",
				action = act.CopyMode("MoveToStartOfNextLine"),
			},
			{
				key = "Escape",
				mods = "NONE",
				action = act.Multiple({
					act.CopyMode("MoveToScrollbackBottom"),
					act.CopyMode("Close"),
				}),
			},
			-- {
			--     key = 'Space',
			--     mods = 'NONE',
			--     action = act.CopyMode { SetSelectionMode = 'Cell' },
			-- },
			{
				key = "Space",
				mods = "NONE",
				action = act.CopyMode("MoveToEndOfLineContent"),
			},
			{
				key = "Space",
				mods = "SHIFT",
				action = act.CopyMode("MoveToEndOfLineContent"),
			},
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{
				key = "F",
				mods = "NONE",
				action = act.CopyMode({ JumpBackward = { prev_char = false } }),
			},
			{
				key = "F",
				mods = "SHIFT",
				action = act.CopyMode({ JumpBackward = { prev_char = false } }),
			},
			{
				key = "G",
				mods = "NONE",
				action = act.CopyMode("MoveToScrollbackBottom"),
			},
			{
				key = "G",
				mods = "SHIFT",
				action = act.CopyMode("MoveToScrollbackBottom"),
			},
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{
				key = "H",
				mods = "SHIFT",
				action = act.CopyMode("MoveToViewportTop"),
			},
			{
				key = "L",
				mods = "NONE",
				action = act.CopyMode("MoveToViewportBottom"),
			},
			{
				key = "L",
				mods = "SHIFT",
				action = act.CopyMode("MoveToViewportBottom"),
			},
			{
				key = "M",
				mods = "NONE",
				action = act.CopyMode("MoveToViewportMiddle"),
			},
			{
				key = "M",
				mods = "SHIFT",
				action = act.CopyMode("MoveToViewportMiddle"),
			},
			{
				key = "O",
				mods = "NONE",
				action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
			},
			{
				key = "O",
				mods = "SHIFT",
				action = act.CopyMode("MoveToSelectionOtherEndHoriz"),
			},
			{
				key = "T",
				mods = "NONE",
				action = act.CopyMode({ JumpBackward = { prev_char = true } }),
			},
			{
				key = "T",
				mods = "SHIFT",
				action = act.CopyMode({ JumpBackward = { prev_char = true } }),
			},
			{
				key = "V",
				mods = "NONE",
				action = act.CopyMode({ SetSelectionMode = "Line" }),
			},
			{
				key = "V",
				mods = "SHIFT",
				action = act.CopyMode({ SetSelectionMode = "Line" }),
			},
			{
				key = "m",
				mods = "NONE",
				action = act.CopyMode("MoveToStartOfLineContent"),
			},
			{
				key = "m",
				mods = "SHIFT",
				action = act.CopyMode("MoveToStartOfLineContent"),
			},
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{
				key = "c",
				mods = "CTRL",
				action = act.Multiple({
					{ CopyMode = "MoveToScrollbackBottom" },
					{ CopyMode = "Close" },
				}),
			},
			{
				key = "d",
				mods = "CTRL",
				action = act.CopyMode({ MoveByPage = 0.5 }),
			},
			{
				key = "e",
				mods = "NONE",
				action = act.CopyMode("MoveForwardWordEnd"),
			},
			{
				key = "f",
				mods = "NONE",
				action = act.CopyMode({ JumpForward = { prev_char = false } }),
			},
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{
				key = "g",
				mods = "NONE",
				action = act.CopyMode("MoveToScrollbackTop"),
			},
			{
				key = "g",
				mods = "CTRL",
				action = act.Multiple({
					{ CopyMode = "MoveToScrollbackBottom" },
					{ CopyMode = "Close" },
				}),
			},
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			-- {
			--     key = 'm',
			--     mods = 'ALT',
			--     action = act.CopyMode 'MoveToStartOfLineContent',
			-- },
			{
				key = "o",
				mods = "NONE",
				action = act.CopyMode("MoveToSelectionOtherEnd"),
			},
			{
				key = "q",
				mods = "NONE",
				action = act.Multiple({
					{ CopyMode = "MoveToScrollbackBottom" },
					{ CopyMode = "Close" },
				}),
			},
			{
				key = "t",
				mods = "NONE",
				action = act.CopyMode({ JumpForward = { prev_char = true } }),
			},
			{
				key = "u",
				mods = "CTRL",
				action = act.CopyMode({ MoveByPage = -0.5 }),
			},
			{
				key = "v",
				mods = "NONE",
				action = act.CopyMode({ SetSelectionMode = "Cell" }),
			},
			{
				key = "v",
				mods = "CTRL",
				action = act.CopyMode({ SetSelectionMode = "Block" }),
			},
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({
					{ CopyTo = "ClipboardAndPrimarySelection" },
					{ CopyMode = "MoveToScrollbackBottom" },
					{ CopyMode = "Close" },
				}),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{
				key = "End",
				mods = "NONE",
				action = act.CopyMode("MoveToEndOfLineContent"),
			},
			{
				key = "Home",
				mods = "NONE",
				action = act.CopyMode("MoveToStartOfLine"),
			},
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{
				key = "LeftArrow",
				mods = "ALT",
				action = act.CopyMode("MoveBackwardWord"),
			},
			{
				key = "RightArrow",
				mods = "NONE",
				action = act.CopyMode("MoveRight"),
			},
			{
				key = "RightArrow",
				mods = "ALT",
				action = act.CopyMode("MoveForwardWord"),
			},
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},
	},
}
