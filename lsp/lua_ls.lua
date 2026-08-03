return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			-- codeLens = { enable = true },
			hint = { enable = true, arrayIndex = "Disable" },
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			completion = { callSnippet = "Replace" },
			format = {
				enable = true,
				defaultConfig = { indent_style = "space", indent_size = "2" },
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME .. "/lua", "${3rd}/luv/library" },
			},
			telemetry = { enable = false },
		},
	},
}
