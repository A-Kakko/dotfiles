return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy", -- cargo check の代わりに clippy を使う
							},
							hover = {
								documentation = {
									enable = true,
									keywords = {
										enable = true,
									},
								},
							},
							completion = {
								fullFunctionSignatures = {
									enable = true,
								},
							},
						},
					},
				},
			},
		},
	},
}
