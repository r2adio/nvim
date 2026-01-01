require("nvim-treesitter.configs").setup({
	sync_install = false,
	auto_install = true,
	ignore_install = { "javascript" },
	highlight = { enable = true },
	indent = { enable = true },
	autotag = { enable = true },

	ensure_installed = {
		"json",
		"python",
		"javascript",
		"typescript",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"query",
		"vimdoc",
		"c",
		"go",
	},

	disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
})
