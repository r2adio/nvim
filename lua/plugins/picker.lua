vim.pack.add({ "gh:ibhagwan/fzf-lua" })

require("fzf-lua").setup({
	winopts = {
		relative = "editor",
		width = 1.00,
		height = 0.33,
		row = 0.95,
		col = 0.50,
		border = "none",
		backdrop = 95,
		preview = { hidden = true },
	},

	fzf_opts = {
		["--layout"] = "default",
		["--height"] = "100%",
		["--border"] = "none",
		["--info"] = "hidden",
		["--scrollbar"] = false,
		["--pointer"] = " ",
		["--marker"] = " ",
	},

	files = {
		previewer = false,
		cwd_prompt = false,
		git_icons = false,
		file_icons = false,
		-- path_shorten = 1,
		fd_opts = [[
      --color=never
      --type f
      --hidden
      --follow
      --exclude .git
    ]],
	},
})
