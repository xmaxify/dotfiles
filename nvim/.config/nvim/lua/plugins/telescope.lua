return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Files (telescope)" },
	},
	tag = "v0.2.0",
	dependencies = { "nvim-lua/plenary.nvim" },
}
