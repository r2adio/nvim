return {
	-- "williamboman/mason.nvim",
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
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
				"python-lsp-server",
				"typescript-language-server",
				"gopls",
				"templ",
				"eslint-lsp",

				-- Formatters, Linters, DAPs
				"prettier",
				"stylua",
				-- "isort",
				"ruff",
				"debugpy",
				"eslint_d",
				"goimports",
			},
		})
	end,
}
