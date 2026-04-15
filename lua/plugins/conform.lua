vim.pack.add({ "gh:stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		javascript = { "biome" },
		typescript = { "biome" },
		javascriptreact = { "biome" },
		typescriptreact = { "biome" },
		svelte = { "biome" },
		astro = { "biome" },
		css = { "biome" },
		html = { "biome" },
		json = { "biome" },
		-- golang = { "golines" },
		go = { "goimports", "gofmt" },
		yaml = { "prettier" },
		markdown = { "biome" },
		graphql = { "biome" },
		liquid = { "biome" },
		lua = { "stylua" },
		python = {
			--[["ruff_fix",]]
			"ruff_format",
			"ruff_organize_imports",
		},
	},
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		require("conform").format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		})
	end,
})
