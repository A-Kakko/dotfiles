return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = true,
				enable_in_insert = false,
				sign = false,
			},
		})
	end,
}
