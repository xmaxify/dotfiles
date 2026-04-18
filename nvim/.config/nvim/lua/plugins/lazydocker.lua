return {
	"crnvl96/lazydocker.nvim",
	event = "VeryLazy",
	opts = {
		window = {
			settings = {
				width = 0.818,
				height = 0.818,
				border = "rounded",
				relative = "editor",
			},
		},
	},
	keys = {
		{
			"<leader>dd",
			"<Cmd>lua require('lazydocker').toggle({ engine = 'docker' })<CR>",
			mode = { "n", "t" },
			desc = "LazyDocker (docker)",
		},

