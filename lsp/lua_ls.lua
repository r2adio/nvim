return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		-- ".luacheckrc",
		-- ".stylua.toml",
		-- "stylua.toml",
		-- "selene.toml",
		-- "selene.yml",
		".git",
	},
	settings = {
		Lua = {
			hint = {
				enable = true, -- enable inlay hints
				arrayIndex = "Enable", -- show hints for array indices
				await = true, -- show hints for `await`
				paramName = "All", -- "All", "Literal", or "Disable"
				paramType = true, -- show parameter type hints
				semicolon = "Disable", -- semicolon hints
				setType = true, -- variable type hints
			},
			-- runtime = { version = "LuaJIT" }, -- LÖVE uses LuaJIT
			-- make the language server recognize "vim" global
			diagnostics = { globals = { "vim", "love" } },
			completion = { callSnippet = "Replace" },
			workspace = {
				checkThirdParty = false,
				-- tells lua_ls where to find all the lua files that you have
				-- loaded for ur nvim config
				library = {
					"${3rd}/luv/library",
					"${3rd}/luassert/library",
					unpack(vim.api.nvim_get_runtime_file("", true)),
				},
			},
		},
	},
}
