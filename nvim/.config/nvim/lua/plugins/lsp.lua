return {
	"neovim/nvim-lspconfig",
	init = function()
		local orig = vim.lsp.handlers["textDocument/publishDiagnostics"]
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
			if result and result.diagnostics and result.uri and result.uri:match("/opt/work/atlasus/axos/ci%-standards/") then
				result.diagnostics = vim.tbl_filter(function(d)
					return not (d.message and d.message:match("does not exist"))
				end, result.diagnostics)
			end
			orig(err, result, ctx, config)
		end
	end,
	opts = {
		servers = {
			yamlls = {
				filetypes = { "yaml", "yaml.gitlab", "yaml.docker-compose" },
				settings = {
					yaml = {
						schemas = {
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
								"*.gitlab",
								".gitlab-ci.yml",
								".gitlab-ci.yaml",
							},
						},
					},
				},
			},
		},
	},
}