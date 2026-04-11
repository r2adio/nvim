vim.lsp.enable({
	"clangd",
	"gopls",
	-- "templ",
	"rust_analyzer",
	"zls",
	"lua_ls",
	"pyright",
	"ruff",
	-- "mesonlsp",
	"ts_ls",
	"tailwind",
	"emmet_ls",
	"astro-ls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then -- nil check for client
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

vim.lsp.codelens.enable() -- do enable in lsp configs
vim.lsp.document_color.enable(true, nil, { style = "virtual" }) -- enable color with tailwind lsp

-- NOTE: need copilot lsp for it
-- vim.lsp.inline_completion.enable()
-- vim.keymap.set("i", "<M-.>", function()
-- 	if not vim.lsp.inline_completion.get() then
-- 		return "<M-.>"
-- 	end
-- end, { desc = "accept the current inline completion" })

vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "enable lsp inlay hints" })

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
			semanticTokens = { multilineTokenSupport = true },
		},
	},
}) -- adding capabilities to vim.lsp

vim.diagnostic.config({
	-- virtual_lines = { current_line = true },
	virtual_text = { current_line = true },
	float = { border = "rounded" },
	update_in_insert = false,
	severity_sort = true,
})

-- vim.api.nvim_create_autocmd("LspProgress", {
-- 	buffer = buf,
-- 	callback = function(ev)
-- 		local value = ev.data.params.value
-- 		vim.api.nvim_echo({ { value.message or "done" } }, false, {
-- 			id = "lsp." .. ev.data.client_id,
-- 			kind = "progress",
-- 			source = "vim.lsp",
-- 			title = value.title,
-- 			status = value.kind ~= "end" and "running" or "success",
-- 			percent = value.percentage,
-- 		})
-- 	end,
-- })
