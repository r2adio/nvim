-- autocmds:

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking test",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
	end,
}) --highlight when yanking text

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
}) -- return to last edit position when opening files

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.js", "*.html", "*.css", "*.lua", "*.md" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.softtabstop = 2
	end,
}) -- javascript, html, css, lua, md formatting

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	callback = function()
		-- vim.opt.textwidth = 79
		-- vim.opt.colorcolumn = "79"
	end,
}) -- python formatting

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nvim-undotree",
	callback = function()
		vim.cmd.wincmd("H")
		vim.api.nvim_win_set_width(0, 40)
	end,
}) -- builtin undotree plugin

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local groups = {
			"DiagnosticUnderlineError",
			"DiagnosticUnderlineWarn",
			"DiagnosticUnderlineInfo",
			"DiagnosticUnderlineHint",
			"DiagnosticUnderlineOk",
		}
		for _, group in ipairs(groups) do
			local hl = vim.api.nvim_get_hl(0, { name = group })
			vim.api.nvim_set_hl(0, group, {
				sp = hl.sp,
				undercurl = true,
			})
		end
	end,
}) -- undercurl over underline for diagnostic lines

vim.api.nvim_create_augroup("AutoCreateDirs", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "AutoCreateDirs",
	pattern = "*",
	callback = function(ctx)
		local dir = vim.fn.fnamemodify(ctx.file, ":h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})
