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

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local bg_color = ""
		local inactive_bg_color = ""
		local groups = {
			"Normal",
			"NormalFloat",
			"SignColumn",
			"FoldColumn",
			"WinSeparator", -- Modern name for VertSplit
		}
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = bg_color })
		end
		vim.api.nvim_set_hl(0, "NormalNC", { bg = inactive_bg_color })
	end,
})

-- Custom command for running SQL queries with URL persistence
vim.api.nvim_create_user_command("DBquery", function(opts)
	---@param url_arg? string
	---@return string|nil
	local function get_db_url(url_arg)
		-- use bang to force prompt for new URL
		if opts.bang then
			local url = vim.fn.input("Database URL: ")
			if url and url ~= "" then
				vim.g.dadbod_last_url = url
				return url
			end
			return nil
		end

		-- use given URL
		if url_arg and url_arg ~= "" then
			vim.g.dadbod_last_url = url_arg
			return url_arg
		end

		-- use last used URL
		if vim.g.dadbod_last_url and vim.g.dadbod_last_url ~= "" then
			return vim.g.dadbod_last_url
		end

		-- prompt for new URL
		local url = vim.fn.input("Database URL: ")
		if url and url ~= "" then
			vim.g.dadbod_last_url = url
			return url
		end

		return nil
	end

	local db_url
	local query
	if #opts.fargs >= 2 then
		-- URL + query
		db_url = get_db_url(opts.fargs[1])
		query = table.concat(opts.fargs, " ", 2)
	elseif #opts.fargs == 1 then
		-- Query only
		db_url = get_db_url(nil)
		query = opts.fargs[1]
	else
		-- No args → buffer / range
		db_url = get_db_url(nil)
	end
	if not db_url then
		vim.notify("No database URL provided", vim.log.levels.ERROR)
		return
	end

	if query then -- Inline query
		vim.cmd("DB " .. db_url .. " " .. query .. "")
		return
	end

	if opts.range == 0 then -- buffer / range execution
		vim.cmd("DB " .. db_url .. " < %")
	else
		vim.cmd(opts.line1 .. "," .. opts.line2 .. "DB " .. db_url)
	end
end, {
	nargs = "?",
	range = true,
	bang = true,
	desc = "Run SQL query with optional database URL (persists last used URL)",
}) -- vim-dadbod custom command
