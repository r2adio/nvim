require("mini.deps").setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- local plugins:
add({
	source = "file://" .. vim.fn.expand("~/projects/pins.nvim"),
	checkout = "master",
})

later(function()
	-- add({ source = "windwp/nvim-ts-autotag" })
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
	add({
		source = "saghen/blink.cmp",
		checkout = "v1.8.0",
		depends = { "rafamadriz/friendly-snippets" },
	})
	add({ source = "mfussenegger/nvim-dap" })
	add({ source = "mistweaverco/kulala.nvim" })
	add({
		source = "tpope/vim-dadbod",
		depends = { "tpope/vim-dispatch" },
		-- depends = { "kristijanhusak/vim-dadbod-ui", "kristijanhusak/vim-dadbod-completion" },
	})
end)

later(function()
	add({ source = "zbirenbaum/copilot.lua" })
	add({ source = "mbbill/undotree" })
	add({ source = "nvim-orgmode/orgmode" })
	add({ source = "chentoast/marks.nvim" })
	add({ source = "norcalli/nvim-colorizer.lua" })
	add({ source = "tpope/vim-fugitive", depends = { "airblade/vim-gitgutter", "tpope/vim-rhubarb" } })
	add({ source = "skanehira/gh.vim" })
end)

now(function()
	add({ source = "sainnhe/gruvbox-material" })
end)

later(function()
	add({ source = "stevearc/conform.nvim" })
	add({ source = "mfussenegger/nvim-lint" })
	add({ source = "mason-org/mason.nvim", depends = { "WhoIsSethDaniel/mason-tool-installer.nvim" } })
end)
