return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", ".git" },
	settings = {
		pylsp = {
			plugins = {
				-- jedi.environment, points to python interpreter inside ur .venv
				jedi = { environment = "./.venv/bin/python" },
				pycodestyle = {
					enabled = false,
					-- ignore = { "W391" },
					-- maxLineLength = 100,
				},
				pyflakes = { enabled = false },
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				mccabe = { enabled = false },
				pylsp_mypy = { enabled = true },
				pylsp_black = { enabled = false },
				pylsp_isort = { enabled = false },
				rope = { enabled = true },
				rope_autoimport = { enabled = true },
			},
		},
	},
}
