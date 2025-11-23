return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			-- オプション設定
		})

		-- キーマップもここに書ける
		vim.keymap.set("n", "<leader>sr", function()
			require("grug-far").open()
		end, { desc = "Search and Replace" })
	end,
}
