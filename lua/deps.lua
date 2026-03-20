require("mini.deps").setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
	add({ source = "nvim-treesitter/nvim-treesitter-context" })
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
	-- add({ source = "comfysage/artio.nvim" })
	add({ source = "ibhagwan/fzf-lua" })
	add({
		source = "saghen/blink.cmp",
		checkout = "v1.8.0",
		depends = { "rafamadriz/friendly-snippets" },
	})
	add({ source = "mfussenegger/nvim-dap" })
	add({ source = "mistweaverco/kulala.nvim" })
	add({
		source = "tpope/vim-dadbod",
		depends = { "kristijanhusak/vim-dadbod-completion" },
	})
end)

later(function()
	add({ source = "ThePrimeagen/99" })
	add({ source = "mbbill/undotree" })
	add({ source = "nvim-orgmode/orgmode" })
	add({ source = "chentoast/marks.nvim" })
	add({ source = "norcalli/nvim-colorizer.lua" })
	add({ source = "tpope/vim-fugitive", depends = { "airblade/vim-gitgutter", "tpope/vim-rhubarb" } })
	-- add({ source = "skanehira/gh.vim" })
	add({ source = "ldelossa/gh.nvim", depends = { "ldelossa/litee.nvim" } })
end)

now(function()
	add({ source = "rose-pine/neovim" })
end)

later(function()
	add({ source = "stevearc/conform.nvim" })
	add({ source = "mfussenegger/nvim-lint" })
	add({ source = "mason-org/mason.nvim", depends = { "WhoIsSethDaniel/mason-tool-installer.nvim" } })
end)
