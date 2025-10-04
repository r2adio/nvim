return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", --integrates lsp completion, w/ completion engine
		{ "antosha417/nvim-lsp-file-operations", config = true }, --adds file operation support to lsp
		{ "folke/neodev.nvim", opts = {} }, --improves lsp support for nvim's lua api
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Define server configurations
		local servers = {
			-- Default setup for most language servers
			ts_ls = {
				settings = {
					format = { enable = true }, -- Enable formatting
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},
			prismals = {},
			clangd = {},
			mesonlsp = {},
			html = {},
			cssls = {},
			tailwindcss = {},
			svelte = {},
			templ = {},
			gopls = {
				settings = {
					gofumpt = true,
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						fieldalignment = true,
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = true,
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					semanticTokens = true,
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						hint = {
							enable = true, -- enable inlay hints
							arrayIndex = "Enable", -- show hints for array indices
							await = true, -- show hints for `await`
							paramName = "All", -- "All", "Literal", or "Disable"
							paramType = true, -- show parameter type hints
							semicolon = "Disable", -- semicolon hints
							setType = true, -- variable type hints
						},
						runtime = { version = "LuaJIT" }, -- LÖVE uses LuaJIT
						-- make the language server recognize "vim" global
						diagnostics = { globals = { "vim", "love" } },
						completion = { callSnippet = "Replace" },
						workspace = {
							-- library = {
							-- 	-- file: https://github.com/love2d-community/love-api/blob/master/love_api.lua
							-- 	[vim.fn.expand("$HOME/.dotfiles/nvim/lua/love-types")] = true, -- Path to love.lua
							-- },
							checkThirdParty = true, -- Avoid unrelated prompts
						},
					},
				},
			},
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			},
			ruff = {},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								enabled = false,
								maxLineLength = 100,
							},
							pyflakes = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = true },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
							rope = { enabled = true },
							rope_autoimport = { enabled = true },
						},
					},
				},
			},
		}
		-- Setup each language server
		for server_name, server_settings in pairs(servers) do
			-- Add capabilities to all servers
			server_settings.capabilities = capabilities

			-- Setup the server with the settings
			lspconfig[server_name].setup(server_settings)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})
		require("lspconfig").pylsp.setup({
			settings = {
				pylsp = {
					plugins = {
						-- jedi.environment, points to python interpreter inside ur .venv
						jedi = { environment = "./.venv/bin/python" },
						pycodestyle = {
							enabled = false,
							-- ignore = { "W391" },
							-- maxLineLength = 100,
						},
						pyflakes = { enabled = false },
						autopep8 = { enabled = false },
						yapf = { enabled = false },
						mccabe = { enabled = false },
						pylsp_mypy = { enabled = true },
						pylsp_black = { enabled = false },
						pylsp_isort = { enabled = false },
						rope = { enabled = true },
						rope_autoimport = { enabled = true },
					},
				},
			},
		})
		vim.diagnostic.config({
			-- virtual_text = true,
			virtual_text = { current_line = true },
			float = { border = "rounded" },
			update_in_insert = false,
			severity_sort = true,
		})

		-- require("lspconfig").ruff.setup({
		--   trace = "messages",
		--   init_options = {
		--     settings = {
		--       logLevel = "info",
		--       -- exclude = "**/tests/**",
		--       lineLength = 79,
		--       fixAll = true,
		--       organizeImports = true,
		--       showSyntaxErrors = true,
		--       codeAction = {
		--         disableRuleComment = {
		--           enable = true,
		--         },
		--         fixViolation = {
		--           enable = true,
		--         },
		--       },
		--       lint = {
		--         enable = true,
		--         preview = true,
		--         select = { "E", "F" },
		--         extendSelect = { "W" },
		--       },
		--       format = {
		--         preview = true,
		--       },
		--     },
		--   },
		-- })
	end,
}
