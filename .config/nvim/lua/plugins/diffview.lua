return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
		{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
	},
	config = function()
		require("diffview").setup({
			diff_binaries = false,
			enhanced_diff_hl = false,
			use_icons = true,
			-- ファイルパネルの設定
			file_panel = {
				listing_style = "tree",
				tree_options = {
					flatten_dirs = true,
					folder_statuses = "only_folded",
				},
				win_config = {
					position = "left",
					width = 35,
				},
			},
			-- ファイル履歴パネルの設定
			file_history_panel = {
				log_options = {
					git = {
						single_file = {
							diff_merges = "combined",
						},
						multi_file = {
							diff_merges = "first-parent",
						},
					},
				},
				win_config = {
					position = "bottom",
					height = 16,
				},
			},
		})
	end,
}
