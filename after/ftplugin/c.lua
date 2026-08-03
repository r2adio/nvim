vim.opt_local.textwidth = 100

-- Comment formatting
vim.opt_local.comments:remove("://")
vim.opt_local.comments:append({ ":///", "://" })

-- Jump to previous section and center a little
vim.keymap.set("n", "[[", "[[3<C-y>", { buffer = true })

-- C indentation options
vim.opt_local.cinoptions = table.concat({
	">s,e0,n0,f0,{0,}0,^0,:s,=s,l1,b0",
	"ps,t0",
	"c3,C1,/0",
	"+s",
	"(0,u0,U1,w1,W0,m0,M0",
	")20,*30",
}, ",")

-- Formatting
if vim.fn.findfile(".clang-format", ";") == "" then
	vim.opt_local.formatprg = "clang-format -style=LLVM"
else
	vim.opt_local.formatprg = "clang-format -style=file"
end

-- Neovim source tree helpers
if vim.fn.expand("%:p"):match("neovim") then
	vim.b.printf_pattern = [[ILOG("%d", %s);]]

	vim.keymap.set("n", "<leader>log", 'oELOG("");<Esc>', {
		buffer = true,
		silent = true,
	})
end

-- :InsertCBreak
vim.api.nvim_buf_create_user_command(0, "InsertCBreak", function()
	vim.api.nvim_put({
		"#include <signal.h>",
		"raise(SIGINT);",
	}, "l", true, true)
end, {})
