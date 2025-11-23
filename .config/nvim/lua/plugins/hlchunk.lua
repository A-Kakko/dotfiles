return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				-- チャンクのスタイル設定
				style = {
					{ fg = "#806d9c" },
				},
				-- 遅延時間（ミリ秒）
				delay = 10,
			},
			indent = {
				enable = true,
				-- インデントガイドの文字
				chars = { "│" },
			},
			line_num = {
				enable = true,
			},
			blank = {
				enable = false,
			},
		})
	end,
}
