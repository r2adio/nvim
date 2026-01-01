local now, later = MiniDeps.now, MiniDeps.later

now(function()
	require("plugins.colorscheme")
end)

later(function()
	require("plugins.pick")
	require("plugins.mason")
	require("plugins.conform")
	require("plugins.lint")
end)

later(function()
	require("plugins.treesitter")
	require("plugins.blink")
	require("plugins.supermaven")
	require("plugins.org")
end)
