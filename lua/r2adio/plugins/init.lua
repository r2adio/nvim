return {
	{
		"mbbill/undotree",
		vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true, desc = "Open UndoTree" }),
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		vim.keymap.set("n", "<leader>cc", function()
			require("colorizer").setup()
		end),
	},
}
