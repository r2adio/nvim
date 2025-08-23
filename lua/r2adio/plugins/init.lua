return {
	{
		"mbbill/undotree",
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true, desc = "Open UndoTree" }),
	},
	{
		"norcalli/nvim-colorizer.lua",
		vim.keymap.set("n", "<leader>cc", function()
			require("colorizer").setup()
		end),
	},
	{
		"NStefan002/screenkey.nvim",
		lazy = true,
		version = "*", -- or branch = "main", to use the latest commit
	},
}
