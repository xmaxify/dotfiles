return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua", "vim", "bash", "python",
      "yaml", "json", "hcl", "dockerfile",
      "terraform", "markdown",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
