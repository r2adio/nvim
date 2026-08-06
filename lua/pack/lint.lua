require("lint").linters_by_ft = {
	javascript = { "biomejs" },
	typescript = { "biomejs" },
	javascriptreact = { "biomejs" },
	typescriptreact = { "biomejs" },
	python = { "ruff" },
	go = {}, -- disable linting for Go
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
			return
		end
		require("lint").try_lint()
	end,
})
