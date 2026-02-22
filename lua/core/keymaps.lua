local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- yank in system clipboard
keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("n", "<leader>Y", '"+Y', { noremap = true, silent = true })

-- replace the all instances of word under the cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- toggle netrw
keymap("n", "<leader>.", "<cmd>Rexplore<cr>") -- reopen last netrew buffer
keymap("n", "<leader><leader>", "<cmd>Explore %:p:h<cr>") -- open fresh netrew buffer at current file directory

-- replace autopairs plugin
local function auto_pairs(open, close)
	return function()
		local col = vim.fn.col(".")
		local line = vim.fn.getline(".")
		local next_char = line:sub(col, col)

		-- If next char is the closing one, just move out
		if next_char == close then
			return "<Right>"
		else
			return open .. close .. "<Left>"
		end
	end
end
keymap("i", '"', auto_pairs('"', '"'), { expr = true })
keymap("i", "'", auto_pairs("'", "'"), { expr = true })
keymap("i", "`", auto_pairs("`", "`"), { expr = true })
keymap("i", "[", auto_pairs("[", "]"), { expr = true })
keymap("i", "(", auto_pairs("(", ")"), { expr = true })
keymap("i", "{", auto_pairs("{", "}"), { expr = true })
keymap("i", "<", auto_pairs("<", ">"), { expr = true })
keymap("i", "/*", "/**/<left><left>")

keymap("i", "<C-l>", "<Del>")

-- kulala.nvim
vim.keymap.set("n", "<leader>x", ":lua require('kulala').",{ silent = true, desc = "Open Kulala" })

-- undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true, desc = "Open UndoTree" })

-- fugitive
vim.keymap.set("n", "gs", vim.cmd.Git)
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("Fugitive_Config", {}),
	pattern = "*",
	callback = function()
		if vim.bo.ft ~= "fugitive" then -- activate only in fugitive buffers
			return
		end
		local bufnr = vim.api.nvim_get_current_buf()
		-- local opts = { buffer = bufnr, noremap = true, silent = true }
		vim.keymap.set("n", "<leader>P", function() -- rebase always
			vim.cmd("Git pull --rebase")
		end, opts)

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
		vim.keymap.set("n", "<leader>ll", ":Git log --graph --decorate --oneline")
		vim.keymap.set("n", "<leader>la", ":Git log --graph --decorate --oneline --all")
	end,
})
vim.keymap.set("n", "<leader>hU", "<cmd>G restore --staged %<cr>", opts)
