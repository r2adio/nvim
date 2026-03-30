vim.pack.add({ "gh:ibhagwan/fzf-lua" })

require("fzf-lua").setup({
	winopts = {
		height = 0.45, -- window height
		width = 1.00, -- window width
		row = 1.00, -- window row position (0=top, 1=bottom)
		col = 1.00, -- window col position (0=left, 1=right)
		border = "rounded",
	},
	fzf_opts = {
		-- options are sent as `<left>=<right>`
		-- set to `false` to remove a flag
		-- set to `true` for a no-value flag
		-- for raw args use `fzf_args` instead
		["--ansi"] = true,
		["--info"] = "inline-right", -- fzf < v0.42 = "inline"
		["--height"] = "100%",
		["--layout"] = "reverse",
		["--border"] = "none",
		["--highlight-line"] = true, -- fzf >= v0.53
	},
})
