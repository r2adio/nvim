require("mini.extra").setup({})
require("mini.pick").setup({
	mappings = {
		choose_marked = "<C-q>",
	},
	window = {
		config = {
			border = "rounded",
			relative = "editor",
		},
		prompt_prefix = "ㄓ",
		prompt_caret = "▓",
	},
})
vim.keymap.set("n", "<leader>p", ":Pick ", { desc = "mini.pick commands" })
-- gray background for selected item
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {
	bg = "#2a2a2a",
	fg = "NONE",
	bold = true,
})

require("mini.test").setup({})
