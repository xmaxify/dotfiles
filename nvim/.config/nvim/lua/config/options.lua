vim.opt.spell = true
vim.opt.spelllang = { "pl", "en" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "NvimTree", "neo-tree", "TelescopePrompt", "lazy", "mason", "help" },
	callback = function()
		vim.opt_local.spell = false
	end,
})
vim.filetype.add({
	pattern = {
		[".*/%.gitlab%-ci%.yml"] = "yaml.gitlab",
		[".*/%.gitlab%-ci%.yaml"] = "yaml.gitlab",
		[".*/ci%-standards/templates/.*%.yml"] = "yaml.gitlab",
	},
})
-- vim.filetype.add({
-- 	pattern = {
-- 		[".*/%.gitlab%-ci%.yml"] = "yaml.gitlab",
-- 		[".*/%.gitlab%-ci%.yaml"] = "yaml.gitlab",
-- 	},
-- })
