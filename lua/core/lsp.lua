vim.lsp.enable({
	"clangd",
	"gopls",
	"templ",
	"rust_analyzer",
	"zls",
	"lua_ls",
	"pyright",
	"ruff",
	"mesonlsp",
	"ts_ls",
	"tailwind",
	"emmet_ls",
	"astro-ls",
})

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

-- lsp inlay_hint
vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "enable lsp inlay hints" })
