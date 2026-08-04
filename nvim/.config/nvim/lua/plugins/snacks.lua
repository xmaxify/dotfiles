return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			explorer = {
				replace_netrw = true,
			},
			picker = {
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
					},
					grep = {
						follow = true,
						hidden = true,
						ignored = true,
					},
				},
			},
		},
	},
}
