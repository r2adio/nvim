return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			-- codeLens = { enable = true },
			hint = { enable = true, arrayIndex = "Disable" },
			runtime = { version = "LuaJIT" },
			diagnostics = {},
			completion = { callSnippet = "Replace" },
			format = {
				enable = true,
				defaultConfig = { indent_style = "space", indent_size = "2" },
			},
			workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			telemetry = { enable = false },
		},
	},
}
