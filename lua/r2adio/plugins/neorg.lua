return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	-- dependencies = { "folke/zen-mode.nvim" },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
				["core.integrations.nvim-cmp"] = {},
				["core.concealer"] = { config = { icon_preset = "diamond" } },
				["core.keybinds"] = {
					-- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
					config = {
						default_keybinds = true,
						neorg_leader = "<Leader><Leader>",
					},
				},
				["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
				["core.qol.toc"] = {},
				["core.qol.todo_items"] = {},
				["core.looking-glass"] = {},
				["core.presenter"] = { config = { zen_mode = "zen-mode" } },
				["core.export"] = {},
				["core.export.markdown"] = { config = { extensions = "all" } },
				["core.summary"] = {},
				["core.tangle"] = { config = { report_on_empty = false } },
				["core.ui.calendar"] = {},
				["core.journal"] = {
					config = {
						strategy = "flat",
						workspace = "Notes",
					},
				},
			},
		})

		-- Add this after your Neorg setup
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "norg",
			callback = function()
				local opts = { buffer = true, silent = true }
				vim.keymap.set("n", "<C-n>", function()
					require("neorg").modules.get_module("core.presenter").next_page()
				end, opts)
				vim.keymap.set("n", "<C-p>", function()
					require("neorg").modules.get_module("core.presenter").previous_page()
				end, opts)
				vim.keymap.set("n", "<C-q>", function()
					require("neorg").modules.get_module("core.presenter").close()
				end, opts)
			end,
		})
	end,
}
