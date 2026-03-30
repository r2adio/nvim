vim.pack.add({ "gh:webhooked/kanso.nvim" })

require("kanso").setup({
	colors = { palette = { zenBg0 = "#000000" } },
})

vim.cmd("colorscheme kanso-zen")
