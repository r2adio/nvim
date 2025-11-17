return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000, -- Ensure this loads early
	config = function()
		-- Define gruvbox settings in a table for clarity
		local gruvbox_settings = {
			terminal_colors = true, -- Enable Neovim terminal colors
			transparent_mode = true, -- Enable transparent background
			overrides = {
				StatusLine = { bg = "NONE" },
				StatusLineNC = { bg = "NONE" },
			},
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			contrast = "hard", -- Options: "hard", "soft", or ""
		}
		-- Apply gruvbox settings
		require("gruvbox").setup(gruvbox_settings)
		-- Set the colorscheme
		vim.cmd("colorscheme gruvbox")
	end,

	-- "rose-pine/neovim",
	-- name = "rose-pine",
	-- config = function()
	-- 	require("rose-pine").setup({
	-- 		variant = "auto", -- auto, main, moon, or dawn
	-- 		dark_variant = "main", -- main, moon, or dawn
	-- 		dim_inactive_windows = false,
	-- 		extend_background_behind_borders = true,
	--
	-- 		enable = {
	-- 			terminal = true,
	-- 			legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
	-- 			migrations = true, -- Handle deprecated options automatically
	-- 		},
	--
	-- 		styles = {
	-- 			bold = true,
	-- 			italic = true,
	-- 			transparency = true,
	-- 		},
	--
	-- 		groups = {
	-- 			border = "muted",
	-- 			link = "iris",
	-- 			panel = "surface",
	--
	-- 			error = "love",
	-- 			hint = "iris",
	-- 			info = "foam",
	-- 			note = "pine",
	-- 			todo = "rose",
	-- 			warn = "gold",
	--
	-- 			git_add = "foam",
	-- 			git_change = "rose",
	-- 			git_delete = "love",
	-- 			git_dirty = "rose",
	-- 			git_ignore = "muted",
	-- 			git_merge = "iris",
	-- 			git_rename = "pine",
	-- 			git_stage = "iris",
	-- 			git_text = "rose",
	-- 			git_untracked = "subtle",
	--
	-- 			h1 = "iris",
	-- 			h2 = "foam",
	-- 			h3 = "rose",
	-- 			h4 = "gold",
	-- 			h5 = "pine",
	-- 			h6 = "foam",
	-- 		},
	--
	-- 		palette = {},
	--
	-- 		-- NOTE: Highlight groups are extended (merged) by default. Disable this
	-- 		-- per group via `inherit = false`
	-- 		highlight_groups = {},
	-- 	})
	--
	-- 	vim.cmd("colorscheme rose-pine")
	-- 	-- vim.cmd("colorscheme rose-pine-main")
	-- 	-- vim.cmd("colorscheme rose-pine-moon")
	-- 	-- vim.cmd("colorscheme rose-pine-dawn")
	-- end,
}
