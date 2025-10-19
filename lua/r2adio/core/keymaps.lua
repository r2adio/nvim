local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text up and down
keymap("v", "<<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- buffers
-- keymap("n", "<leader>bp", ":bp<cr>", opts) -- use [b
-- keymap("n", "<leader>bn", ":bn<cr>", opts) -- use ]b
keymap("n", "<leader>bk", ":bd<cr>", opts)

-- primeagen
-- yank in system clipboard
keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
keymap("n", "<leader>Y", '"+Y', { noremap = true, silent = true })
keymap("x", "<leader>p", '"_dP', { noremap = true, silent = true })

-- replace the all instances of word under the cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- make the script executable.
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- for plugin testings
keymap("n", "<leader>T", "<cmd>PlenaryBustedFile %<cr>", opts)

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

-- lsp inlay_hint
keymap("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
