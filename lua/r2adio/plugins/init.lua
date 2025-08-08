return {
	{
		"NvChad/nvim-colorizer.lua",
		keys = {
			"<leader>cc",
			"<cmd>ColorizerToggle<cr>",
			mode = "n",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
