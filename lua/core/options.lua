vim.o.nu = true -- enable line numbers
vim.o.relativenumber = true -- relative line numbers
vim.o.backup = false -- creates a backup file
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.o.autocomplete = true -- enable native completion engine
vim.opt.complete = "o,.,w,b,u,t" -- omni func, current buffer, then windows...
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview", "fuzzy", "noinsert" } -- for cmp menu
-- vim.opt.completeitemalign = { "kind", "abbr", "menu" } -- align menu items
vim.opt.shortmess:append("c")
vim.o.conceallevel = 2 -- so that `` is visible in markdown files
vim.o.encoding = "utf-8" -- set encoding
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.hlsearch = true -- highlight all matches on previous search pattern
vim.o.incsearch = true -- show search results as you type
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.mouse = "" -- allow the mouse to be used in neovim
vim.o.pumheight = 10 -- pop up menu height
vim.o.showmode = true -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 1 -- always show tabs
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.laststatus = 3
vim.o.swapfile = false -- creates a swapfile
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.undofile = true -- enable persistent undo
vim.o.updatetime = 300 -- faster completion (4000ms default)
vim.o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.cursorline = true -- highlight the current line
vim.o.numberwidth = 2 -- set number column width to 2 {default 4}
vim.o.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.o.wrap = true -- display lines as one long line
vim.o.linebreak = true --wraps lines at word boundaries
vim.o.scrolloff = math.floor(vim.o.lines / 2) - 7 -- will always keep 8 lines of context
vim.o.sidescrolloff = 8
vim.o.guicursor = ""
vim.o.colorcolumn = "100"
vim.o.winborder = "single"
vim.o.pumborder = "single"
vim.opt.exrc = true

-- tags, dict and thesaurus
vim.opt.tags = { "./tags", "tags" } --i_CTRL-X_CTRL-]
vim.opt.dictionary = { -- i_CTRL-X_CTRL-K
	"/usr/share/dict/words",
	vim.fn.stdpath("config") .. "/dict/custom.dict",
}

-- fold options
vim.o.foldmethod = "expr" -- with lsp+treesitter
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()" -- look for active lsp to fold
vim.o.foldcolumn = "0" -- dedicated column for folds
vim.o.foldlevel = 99 -- fold level stay open
vim.o.foldlevelstart = 99 -- applied only when opening a file
vim.o.foldenable = true

-- grep options
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden --glob '!.git'"
vim.o.grepformat = "%f:%l:%c:%m"

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
vim.cmd("packadd nvim.undotree") -- enable default undotree plugin

-- netrw plugin (replaced by net.lua in nvim 0.12)
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_nvim_net_plugin = 0

vim.opt.path:append("**")
vim.opt.wildignore:append({
	"*/node_modules/*",
	"*/dist/*",
	"*/build/*",
	-- "*/.git/*",
	"*/.cache/*",
	"*/.next/*",
	"*.log",
})

vim.opt.whichwrap:append("<,>,[,]")
vim.opt.iskeyword:append("-") -- treat hyphens as part of a word

-- --- wraps message with tmux prefix so that the underlying terminal can interpret it correctly
-- --- needs 'set-option -g allow-passthrough on' in tmux config
-- ---@param content string
-- ---@return string
-- local function wrap_tmux(content)
-- 	return string.format("\27Ptmux;\27%s\27\\", content)
-- end
-- local original_ui_send = vim.api.nvim_ui_send
-- ---@diagnostic disable-next-line: duplicate-set-field
-- vim.api.nvim_ui_send = function(content)
-- 	-- wrap in TMUX passthrough if needed
-- 	if os.getenv("TMUX") then
-- 		content = wrap_tmux(content)
-- 	end
-- 	original_ui_send(content)
-- end
