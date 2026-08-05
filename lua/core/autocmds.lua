-- autocmds:

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
	end,
}) --highlight when yanking text

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
}) -- return to last edit position when opening files

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

vim.api.nvim_create_autocmd("CompleteChanged", {
	group = vim.api.nvim_create_augroup("CompletionDocBorder", { clear = true }),
	callback = function()
		vim.schedule(function()
			local info = vim.fn.complete_info({ "selected", "preview_winid" })
			if
				info.preview_winid
				and info.preview_winid >= 0
				and vim.api.nvim_win_is_valid(info.preview_winid)
			then
				pcall(vim.api.nvim_win_set_config, info.preview_winid, { border = "single" })
			end
		end)
	end,
})

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
