vim.o.nu = true -- enable line numbers

vim.o.relativenumber = true -- relative line numbers
vim.o.backup = false -- creates a backup file
-- vim.o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.o.cmdheight = 0 -- more space in the neovim command line for displaying messages
-- vim.o.autocomplete = true
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "popup", "fuzzy" } -- mostly just for cmp
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
-- vim.o.splitbelow = true -- force all horizontal splits to go below current window
-- vim.o.splitright = true -- force all vertical splits to go to the right of current window
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
vim.o.scrolloff = 8 -- will always keep 8 lines of context
vim.o.sidescrolloff = 8
vim.o.guicursor = ""
vim.o.colorcolumn = "100"
vim.o.winborder = "rounded"

-- grep options
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden --glob '!.git'"
vim.o.grepformat = "%f:%l:%c:%m"

require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = {
			[""] = "msg",
			empty = "cmd",
			bufwrite = "msg",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = { height = 0.5 },
		dialog = { height = 0.5 },
		msg = { height = 0.3, timeout = 5000 },
		pager = { height = 0.5 },
	},
}) -- enables ui2 (exp in v0.12)
vim.opt.rtp:append("~/projects/exec.nvim")

vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree") -- enable default undotree plugin

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

vim.opt.path:append("**")
vim.opt.wildignore:append({
	"*/node_modules/*",
	"*/dist/*",
	"*/build/*",
	"*/.git/*",
	"*/.cache/*",
	"*/.next/*",
	"*.log",
})

vim.opt.whichwrap:append("<,>,[,]")
vim.opt.iskeyword:append("-") -- treat hyphens as part of a word
