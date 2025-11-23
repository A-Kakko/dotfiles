return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
			},
		})

		-- /* */ のルールを追加
		npairs.add_rules({
			Rule("/*", "*/"):with_move(function(opts)
				return opts.char == "/"
			end),
		})
	end,
}
