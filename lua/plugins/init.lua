local now, later = MiniDeps.now, MiniDeps.later

now(function()
	require("plugins.colorscheme")
	require("plugins.local")
end)

later(function()
	require("plugins.mini")
	require("plugins.mason")
	require("plugins.dap")
	require("plugins.conform")
	require("plugins.lint")
end)

later(function()
	require("plugins.treesitter")
	require("plugins.blink")
	require("plugins.copilot")
	require("plugins.org")
	require("plugins.marks")
	require("plugins.kulala")
end)
