return {
	"bassamsdata/namu.nvim",
	event = "LspAttach",
	opts = {
		global = {},
		namu_symbols = {
			options = {},
		},
	},
	keys = {
		{
			"<leader>ss",
			"<cmd>Namu symbols<cr>",
			desc = "Jump to LSP symbol",
		},
		{
			"<leader>sw",
			"<cmd>Namu workspace<cr>",
			desc = "LSP Symbols - Workspace",
		},
	},
}
