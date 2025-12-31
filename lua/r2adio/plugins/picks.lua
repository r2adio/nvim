return {
	"nvim-mini/mini.pick",
	version = false,
	lazy = false,
	dependencies = { "nvim-mini/mini.extra" },
	config = function()
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

		local keymap = vim.keymap.set
		keymap("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find Files" })
		keymap("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "Live Grep" })
		keymap("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Find Buffers" })
		keymap("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Find Help" })
		keymap("n", "<leader>fk", "<cmd>Pick keymaps<cr>", { desc = "Keymaps" })

		-- gray background for selected item
		vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {
			bg = "#2a2a2a",
			fg = "NONE",
			bold = true,
		})
	end,
}
