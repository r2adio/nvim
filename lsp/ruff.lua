return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	-- settings = {
	-- 	ruff = { builtins = true, config = true, ignore = true, per_line_ignore = true },
	-- },
}
