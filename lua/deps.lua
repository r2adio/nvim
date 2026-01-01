require("mini.deps").setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
	add({ source = "windwp/nvim-ts-autotag" })
	-- add({ source = "nvim-treesitter/nvim-treesitter-context" })
	add({
		source = "nvim-treesitter/nvim-treesitter",
		-- Use 'master' while monitoring updates in 'main'
		checkout = "master",
		monitor = "main",
		-- Perform action after every checkout
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
end)

later(function()
	add({
		source = "saghen/blink.cmp",
		checkout = "v1.8.0",
		depends = { "rafamadriz/friendly-snippets" },
	})
end)

later(function()
	add({ source = "supermaven-inc/supermaven-nvim" })
	add({ source = "mbbill/undotree" })
	add({ source = "nvim-orgmode/orgmode" })
	add({ source = "norcalli/nvim-colorizer.lua" })
	add({ source = "tpope/vim-fugitive", depends = { "airblade/vim-gitgutter" } })
end)

now(function()
	add({ source = "cranberry-clockworks/coal.nvim" })
end)

-- add({ source = "mfussenegger/nvim-dap",depends={} })
later(function()
	add({ source = "stevearc/conform.nvim" })
	add({ source = "mfussenegger/nvim-lint" })
	add({ source = "mason-org/mason.nvim", depends = { "WhoIsSethDaniel/mason-tool-installer.nvim" } })
end)
