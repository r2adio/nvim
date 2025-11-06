return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	settings = {},
	capabilities = {
		experimental = {
			serverStatusNotification = true,
			commands = {
				commands = {
					"rust-analyzer.showReferences",
					"rust-analyzer.runSingle",
					"rust-analyzer.debugSingle",
				},
			},
		},
	},
}
