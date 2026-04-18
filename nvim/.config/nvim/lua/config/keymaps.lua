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
-- floating windows with values
local function open_float_file(filename)
	local filepath = vim.fn.expand("%:h") .. "/" .. filename

	if vim.fn.filereadable(filepath) == 0 then
		vim.notify(filename .. " nie znaleziono", vim.log.levels.WARN)
		return
	end

	local buf = vim.fn.bufadd(filepath)
	vim.fn.bufload(buf)

	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.4)

	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})

	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
end

vim.keymap.set("n", "<leader>tv", function()
	open_float_file("terraform.tfvars")
end, { desc = "Preview terraform.tfvars" })

vim.keymap.set("n", "<leader>te", function()
	open_float_file(".env")
end, { desc = "Preview .env" })
-- end floating windows with values
-- floating windows with search
local function open_float_file_with_search(filename)
	vim.cmd('noau normal! "vy"')
	local search = vim.fn.getreg("v")
	search = string.gsub(search, "\n", "")

	local filepath = vim.fn.expand("%:h") .. "/" .. filename

	if vim.fn.filereadable(filepath) == 0 then
		vim.notify(filename .. " nie znaleziono", vim.log.levels.WARN)
		return
	end

	local buf = vim.fn.bufadd(filepath)
	vim.fn.bufload(buf)

	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.4)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})

	if search ~= "" then
		vim.fn.search(search)
	end

	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
end

vim.keymap.set("v", "<leader>tv", function()
	open_float_file_with_search("terraform.tfvars")
end, { desc = "Preview tfvars (search selection)" })

vim.keymap.set("v", "<leader>te", function()
	open_float_file_with_search(".env")
end, { desc = "Preview .env (search selection)" })
-- end floating windows with search
vim.keymap.set("v", "<leader>sg", function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	text = string.gsub(text, "\n", "")
	Snacks.picker.grep({ search = text })
end, { desc = "Grep Selection" })
