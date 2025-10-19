return {
	cmd = { "clangd", "--background-index" },
	root_markers = { "compile_commands.json", "compile_flags.txt", "Makefile" },
	filetypes = { "c", "cpp" },

	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	},
}
