require("set")
require("autocmds")
require("lsp")
require("pack")
require("colorscheme")
require("remap")

require("vim._core.ui2").enable({
	enable = true,
	msg = {
		---@type 'cmd'|'msg' Default message target, either in the
		---cmdline or in a separate ephemeral message window.
		---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
		---or table mapping |ui-messages| kinds and triggers to a target.
		targets = "cmd",
		cmd = { height = 0.5 },
		dialog = { height = 0.5 },
		msg = { height = 0.5, timeout = 4000 },
		pager = { height = 0.5 },
	},
})

vim.cmd("packadd cfilter")
vim.cmd("packadd nvim.difftool")
vim.cmd("packadd nvim.undotree")

-- disable netrw plugin
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
