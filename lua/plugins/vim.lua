vim.pack.add({ "gh:tpope/vim-fugitive", "gh:airblade/vim-gitgutter" })

vim.pack.add({ "gh:tpope/vim-dadbod", "gh:kristijanhusak/vim-dadbod-completion" })

vim.pack.add({ "file:///Users/ritikh/projects/exec.nvim" })

vim.pack.add({ "gh:stevearc/oil.nvim" })
require("oil").setup({
	columns = { "permissions", "size", "mtime" },
	view_options = { show_hidden = true },
})
