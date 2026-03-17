vim.opt.spell = true
vim.opt.spelllang = { "pl", "en" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree", "neo-tree", "TelescopePrompt", "lazy", "mason", "help" },
  callback = function()
    vim.opt_local.spell = false
  end,
})
