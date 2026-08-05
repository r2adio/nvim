vim.bo.omnifunc = "vim_dadbod_completion#omni"

-- SQL comments
vim.bo.commentstring = "-- %s"

local opts = { buffer = true, silent = true }

-- Execute entire buffer
vim.keymap.set("n", "yxal", "<Cmd>%DBExecRangeSQL<CR>", opts)

-- Execute current line
vim.keymap.set("n", "yxx", "<Cmd>.,.DBExecRangeSQL<CR>", opts)

-- Execute visual selection
vim.keymap.set("x", "<CR>", "<Plug>DBExecVisualSQL", { buffer = true })
