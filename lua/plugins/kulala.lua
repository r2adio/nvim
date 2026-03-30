-- vim.pack.add({ { src = "gh:mistweaverco/kulala.nvim" } })
vim.pack.add({ { src = "gh:mistweaverco/kulala.nvim", opts = { ft = "http" } } })

require("kulala").setup({
	global_keymaps = true,
	-- global_keymaps_prefix = "<leader>x",
})
