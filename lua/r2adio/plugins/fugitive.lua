return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

		local fug = vim.api.nvim_create_augroup("Fugitive_Config", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = fug,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then -- activate only in fugitive buffers
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "<leader>P", function() -- rebase always
					vim.cmd.Git({ "pull", "--rebase" })
				end, opts)

				-- NOTE: It allows me to easily set the branch i am pushing and any tracking
				-- needed if i did not set the branch up correctly
				vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
				vim.keymap.set("n", "<leader>ll", ":Git log --graph --decorate --oneline --all")
			end,
		})

		-- vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
		-- vim.keymap.set("n", "gu", "<cmd>diffget //3<CR>")
	end,
}
