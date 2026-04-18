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
		{
			"<leader>dl",
			function()
				local services = vim.fn.systemlist("docker compose config --services 2>/dev/null")
				if vim.v.shell_error ~= 0 or #services == 0 then
					vim.notify("Nie znaleziono serwisów", vim.log.levels.WARN)
					return
				end

				require("telescope.builtin").find_files({
					prompt_title = "Docker Service",
					finder = require("telescope.finders").new_table({ results = services }),
					attach_mappings = function(_, map)
						map("i", "<CR>", function(bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							require("telescope.actions").close(bufnr)
							Snacks.terminal("docker compose logs -f " .. selection[1])
						end)
						return true
					end,
				})
			end,
			desc = "Docker Compose Logs (telescope)",
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
