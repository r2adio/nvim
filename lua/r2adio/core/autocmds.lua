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

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "aerospace.toml" },
	command = "!aerospace reload-config",
}) -- reload aerospace config

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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		-- nil check for client
		if not client then
			return
		end
		-- check if blink.cmp or nvim-cmp is loaded
		local has_blink = pcall(require, "blink.cmp")
		local has_cmp = pcall(require, "cmp")

		-- only enable native completion if no completion plugin exists
		if not has_blink and not has_cmp then
			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
			end
		end
	end,
}) -- auto-completion w/ vim.lsp.completion.enable

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "coal",
	callback = function()
		-- Transparent backgrounds
		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })

		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#4a4949" })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#4a4949" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "", bold = true })

		-- vim.api.nvim_set_hl(0, "GitGutterAdd", { fg = "#a5a5a5" })
		-- vim.api.nvim_set_hl(0, "GitGutterChange", { fg = "#a5a5a5" })
		-- vim.api.nvim_set_hl(0, "GitGutterDelete", { fg = "#a5a5a5" })

		vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = "#999999" }) -- 153
		vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { fg = "#999999" }) -- 153
		vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { fg = "#737373", bold = true }) -- 115
	end,
}) -- coal colorscheme
