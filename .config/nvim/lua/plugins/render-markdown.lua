return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons", -- アイコン表示用（オプション）
	},
	config = function()
		require("render-markdown").setup({
			-- ヘッドラインのハイライト
			heading = {
				enabled = true,
				sign = true,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			},
			-- コードブロック
			code = {
				enabled = true,
				sign = true,
				style = "full",
				width = "block",
			},
			-- 箇条書き
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
			},
			-- チェックボックス
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			-- 引用
			quote = {
				enabled = true,
				icon = "▎",
			},
			-- リンク
			link = {
				enabled = true,
			},
		})
	end,
}
