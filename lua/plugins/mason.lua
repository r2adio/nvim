vim.pack.add({ "gh:mason-org/mason.nvim", "gh:WhoIsSethDaniel/mason-tool-installer.nvim" })

local mason = require("mason")
local mason_tool_installer = require("mason-tool-installer")
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
mason_tool_installer.setup({
	ensure_installed = {
		-- LSPs
		"clangd",
		"mesonlsp",
		-- "html",
		-- "cssls",
		"tailwindcss-language-server",
		"lua-language-server",
		-- "graphql",
		"emmet-language-server",
		"prisma-language-server",
		"pyright",
		"typescript-language-server",
		"zls",
		"gopls",
		"templ",
		"eslint-lsp",

		-- Formatters, Linters, DAPs
		"prettier",
		"stylua",
		"ruff",
		"eslint_d",
		"goimports",

		-- debuggers
		"codelldb",
		"debugpy",
	},
})
