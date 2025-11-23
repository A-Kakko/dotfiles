return {
	"ysmb-wtsg/in-and-out.nvim",
	event = "VeryLazy",
	config = function()
		require("in-and-out").setup({
			-- デフォルトのキーマップ: Alt+l で次の閉じカッコへ移動
			-- カスタマイズする場合:
			-- mapping = "<M-l>", -- Altキー + l
			-- または
			-- mapping = "<C-l>", -- Ctrl + l

			-- 追加のオプション
			-- mode = "n", -- ノーマルモードのみ、挿入モードでも使う場合は "i" も追加
		})
	end,
}
