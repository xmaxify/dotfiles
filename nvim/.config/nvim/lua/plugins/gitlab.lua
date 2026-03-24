return {
	"harrisoncramer/gitlab.nvim",
	branch = "main",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"stevearc/dressing.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	build = function()
		require("gitlab.server").build(true)
	end,
	event = "BufRead",
	config = function()
		require("gitlab").setup({
			create_mr = {
				squash = false,
			},
		})
	end,
}
