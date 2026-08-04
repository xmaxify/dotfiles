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

-- terminal
map("n", "<C-/>", "<cmd>split | terminal<cr><cmd>startinsert<cr>", "Open terminal")

-- schowanie podświetlenia wyszukiwania
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", "Find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help tags")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent files")
