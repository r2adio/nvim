local keymap = vim.keymap.set
local opts = { buffer = true, noremap = true, silent = true }

keymap("n", "<leader>P", function() -- rebase always
	vim.cmd("Git pull --rebase")
end, opts)

-- NOTE: It allows me to easily set the branch i am pushing and any tracking
-- needed if i did not set the branch up correctly
keymap("n", "<leader>t", ":Git push -u origin ", opts)
keymap("n", "<leader>ll", ":Git log --graph --decorate --oneline<cr>", opts)
keymap("n", "<leader>la", ":Git log --graph --decorate --oneline --all<cr>", opts)
