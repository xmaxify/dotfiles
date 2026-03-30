vim.keymap.set({ "i", "v" }, "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-/>", function()
	Snacks.terminal(nil, { cwd = LazyVim.root() })
	vim.cmd("startinsert")
end, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "diff",
	callback = function()
		if vim.v.option_new == true then
			vim.keymap.set("n", "<leader>ag", "<cmd>diffput<cr>", { buffer = true, desc = "Accept Claude's hunk" })
			vim.keymap.set("n", "<leader>an", "]c", { buffer = true, desc = "Next diff hunk" })
			vim.keymap.set("n", "<leader>ap", "[c", { buffer = true, desc = "Prev diff hunk" })
			vim.keymap.set("n", "<leader>aD", function()
				local current_buf = vim.api.nvim_get_current_buf()
				local target_win = vim.b[current_buf].claudecode_diff_target_win
				if target_win and vim.api.nvim_win_is_valid(target_win) then
					vim.api.nvim_win_call(target_win, function()
						vim.cmd("w")
					end)
				else
					vim.notify("Nie znaleziono okna z oryginalnym plikiem", vim.log.levels.WARN)
					return
				end
				vim.cmd("ClaudeCodeDiffDeny")
			end, { buffer = true, desc = "Save and close diff (selective accept)" })
		else
			pcall(vim.keymap.del, "n", "<leader>ag", { buffer = true })
			pcall(vim.keymap.del, "n", "<leader>an", { buffer = true })
			pcall(vim.keymap.del, "n", "<leader>ap", { buffer = true })
			pcall(vim.keymap.del, "n", "<leader>aD", { buffer = true })
		end
	end,
})
