vim.pack.add({
	{ src = "gh:nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "gh:nvim-treesitter/nvim-treesitter-context" },
})

local parsers_to_install = {
	"json",
	"python",
	"javascript",
	"typescript",
	"yaml",
	"html",
	"css",
	"markdown",
	"markdown_inline",
	"graphql",
	"bash",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"query",
	"vimdoc",
	"c",
	"go",
}

-- installs parsers if not installed (runs asynchronously)
vim.defer_fn(function()
	local ok, ts = pcall(require, "nvim-treesitter")
	if not ok then
		vim.notify("Failed to load nvim-treesitter: " .. ts, vim.log.levels.ERROR)
		return
	end
	local installed = ts.get_installed()
	local to_install = vim.tbl_filter(function(lang)
		return not vim.tbl_contains(installed, lang)
	end, parsers_to_install)
	if #to_install > 0 then
		-- notify if parsers are missing
		vim.notify(string.format("Installing %d treesitter parsers in background...", #to_install), vim.log.levels.INFO)
		require("nvim-treesitter").install(to_install)
	end
end, 100)

-- add highlighting (replaces highlight module)
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter highlighting",
	group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()

		-- not load treesitter for file > 100KB
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return
		end

		pcall(vim.treesitter.start, buf) -- starts the treesitter highlighting
	end,
})

-- NOTE: Indentation is marked as EXPERIMENTAL in main branch
-- main branch's recommendation: enable only for stable languages
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable treesitter indentation",
	group = vim.api.nvim_create_augroup("treesitter-indent", { clear = true }),
	pattern = {
		"lua",
		"python",
		"javascript",
		"typescript",
		"go",
		"c",
		"json",
		"yaml",
		"html",
		"css",
		"markdown",
		"bash",
	},
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- NOTE: The incremental_selection module was removed from main branch
-- Custom implementation:  ## TODO

require("treesitter-context").setup({
	enable = true,
	multiwindow = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = "outer",
	mode = "cursor",
	separator = nil,
	zindex = 20,
	on_attach = nil,
})

-- auto-update parsers when updating nvim-treesitter
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
			vim.notify("nvim-treesitter updated, running update...", vim.log.levels.INFO)

			-- using new api instead of :TSUpdate command
			local ok, result = pcall(function()
				return require("nvim-treesitter").update(parsers_to_install)
			end)
			if ok then
				result:wait(300000) -- 5 min
				vim.notify("Treesitter parsers updated successfully!", vim.log.levels.INFO)
			else
				vim.notify("Failed to update parsers: " .. tostring(result), vim.log.levels.WARN)
			end
		end
	end,
})

-- command to check parser status
vim.api.nvim_create_user_command("TSStatus", function()
	local installed = require("nvim-treesitter").get_installed()
	local missing = vim.tbl_filter(function(lang)
		return not vim.tbl_contains(installed, lang)
	end, parsers_to_install)
	vim.notify(
		string.format(
			"Installed: %d/%d parsers\nMissing: %s",
			#installed,
			#parsers_to_install,
			#missing > 0 and table.concat(missing, ", ") or "none"
		),
		vim.log.levels.INFO
	)
end, {})
