return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"bash",
				"python",
				"yaml",
				"json",
				"hcl",
				"dockerfile",
				"terraform",
				"markdown",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
