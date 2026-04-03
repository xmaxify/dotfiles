return {
	"mason-org/mason.nvim",
	opts = {
		ensure_installed = {
			"bash-language-server",
			"shellcheck",
			"shfmt",
			"prettier",
			"yamlfmt",
			"hadolint",
			"ansible-lint",
			"tflint",
			"gitlab-ci-ls",
			"yamllint",
		},
	},
}
