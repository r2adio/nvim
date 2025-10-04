return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"leoluz/nvim-dap-go",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang")({
					dap = { justMyCode = false },
				}),
			},
		})

		vim.keymap.set("n", "<leader>Tr", function()
			require("neotest").run.run({
				suite = false,
				testify = true,
			})
		end, { desc = "Debug: Running Nearest Test" })

		vim.keymap.set("n", "<leader>Tv", function()
			require("neotest").summary.toggle()
		end, { desc = "Debug: Summary Toggle" })

		vim.keymap.set("n", "<leader>Ts", function()
			require("neotest").run.run({
				suite = true,
				testify = true,
			})
		end, { desc = "Debug: Running Test Suite" })

		vim.keymap.set("n", "<leader>Td", function()
			require("neotest").run.run({
				suite = false,
				testify = true,
				strategy = "dap",
			})
		end, { desc = "Debug: Debug Nearest Test" })

		vim.keymap.set("n", "<leader>To", function()
			require("neotest").output.open()
		end, { desc = "Debug: Open test output" })

		vim.keymap.set("n", "<leader>Ta", function()
			require("neotest").run.run(vim.fn.getcwd())
		end, { desc = "Debug: Open test output" })
	end,
}
