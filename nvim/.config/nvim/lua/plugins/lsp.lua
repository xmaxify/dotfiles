return {
	{ "b0o/SchemaStore.nvim", lazy = true },
	{
		"neovim/nvim-lspconfig",
		init = function()
			-- filtruj diagnostyki dla ci-standards
			local orig = vim.lsp.handlers["textDocument/publishDiagnostics"]
			vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
				if
					result
					and result.diagnostics
					and result.uri
					and result.uri:match("/opt/work/atlasus/axos/ci%-standards/")
				then
					result.diagnostics = vim.tbl_filter(function(d)
						return not (d.message and d.message:match("does not exist"))
					end, result.diagnostics)
				end
				orig(err, result, ctx, config)
			end

			-- wyłącz bashls dla .env
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = ".env*",
				callback = function()
					vim.schedule(function()
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						for _, client in ipairs(clients) do
							if client.name == "bashls" then
								vim.lsp.buf_detach_client(0, client.id)
							end
						end
					end)
				end,
			})
		end,
		opts = {
			servers = {
				-- yaml z lazy schemastore
				yamlls = {
					filetypes = { "yaml", "yaml.gitlab", "yaml.docker-compose" },
					on_attach = function(client)
						client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
							yaml = {
								schemas = require("schemastore").yaml.schemas(),
							},
						})
						client.notify("workspace/didChangeConfiguration", {
							settings = client.config.settings,
						})
					end,
					settings = {
						yaml = {
							schemaStore = { enable = false, url = "" },
							validate = true,
							format = { enable = true },
						},
					},
				},

				-- bash
				bashls = {
					filetypes = { "sh", "bash", "zsh" },
				},

				-- terraform
				terraformls = {
					settings = {
						terraform = {
							experimentalFeatures = {
								prefillRequiredFields = true,
								validateOnSave = true,
							},
						},
					},
				},

				-- docker
				dockerls = {},

				-- gitlab ci
				gitlab_ci_ls = {},

				-- ansible
				ansiblels = {
					settings = {
						ansible = {
							validation = {
								enabled = true,
								lint = { enabled = true },
							},
						},
					},
				},
			},
		},
	},
}
