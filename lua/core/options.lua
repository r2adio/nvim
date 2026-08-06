vim.o.nu = true -- enable line numbers
vim.o.relativenumber = true -- relative line numbers
vim.o.autocomplete = true -- enable native completion engine
vim.opt.complete = "o,.,w,b" -- omni func, current buffer, windows...
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy", "noinsert" } -- for cmp menu
-- vim.opt.completeitemalign = { "kind", "abbr", "menu" } -- align menu items
vim.opt.shortmess:append("c")
vim.o.conceallevel = 1 -- so that `` is visible in markdown files
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.hlsearch = true -- highlight all matches on previous search pattern
vim.o.ignorecase = true -- ignore case in search patterns
vim.o.mouse = "" -- allow the mouse to be used in neovim
vim.o.pumheight = 10 -- pop up menu height
vim.o.smartcase = true -- smart case
vim.o.smartindent = true -- make indenting smarter again
vim.o.laststatus = 3 -- always and ONLY the last window
vim.o.swapfile = false -- creates a swapfile
vim.o.termguicolors = true -- set term gui colors (most terminals support this)
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
vim.o.linebreak = true --wraps lines at word boundaries
vim.o.scrolloff = math.floor(vim.o.lines / 2) - 7 -- minimal no. of columns to scroll horizontally
vim.o.sidescrolloff = 8 -- minimal columns to keep to left and right to cursor
vim.o.guicursor = "" -- dont change cursor
vim.o.colorcolumn = "100"
vim.o.winborder = "single"
vim.o.pumborder = "none"
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
vim.o.foldlevel = 99 -- fold level stay open
vim.o.foldlevelstart = 99 -- applied only when opening a file

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

