vim.pack.add({ "gh:rose-pine/neovim" })
-- vim.cmd("colorscheme retrobox")

require("rose-pine").setup({
	variant = "auto",
	styles = {
		bold = true,
		italic = true,
		transparency = true,
	},
})
vim.cmd("colorscheme rose-pine-moon")
