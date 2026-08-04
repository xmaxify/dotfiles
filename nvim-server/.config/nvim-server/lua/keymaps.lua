local map = function(modes, lhs, rhs, desc)
	vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map({ "i", "v" }, "jk", "<Esc>", "Escape")
map("t", "jk", "<C-\\><C-n>", "Escape terminal")

-- clipboard (OSC52 przez SSH)
map({ "n", "v" }, "y", '"+y', "Yank to clipboard")
map({ "n", "v" }, "Y", '"+Y', "Yank line to clipboard")
map({ "n", "v" }, "p", '"+p', "Paste from clipboard")
map({ "n", "v" }, "P", '"+P', "Paste before from clipboard")

-- nawigacja po oknach
map("n", "<C-h>", "<C-w>h", "Move to left window")
map("n", "<C-j>", "<C-w>j", "Move to bottom window")
map("n", "<C-k>", "<C-w>k", "Move to top window")
map("n", "<C-l>", "<C-w>l", "Move to right window")

-- przesuwanie linii w visual mode
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")

-- terminal (bottom split, toggle)
local term_win, term_buf

local function toggle_terminal()
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_hide(term_win)
		term_win = nil
		return
	end

	vim.cmd("botright split")
	term_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_height(term_win, math.floor(vim.o.lines * 0.3))

	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.api.nvim_win_set_buf(term_win, term_buf)
	else
		vim.cmd.terminal()
		term_buf = vim.api.nvim_get_current_buf()
	end

	vim.cmd.startinsert()
end

map({ "n", "t" }, "<leader>ft", toggle_terminal, "Toggle terminal (bottom split)")

-- schowanie podświetlenia wyszukiwania
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", "Find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help tags")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent files")
