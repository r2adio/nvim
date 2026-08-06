vim.g.mapleader = " "
vim.o.nu = true
vim.o.relativenumber = true

vim.o.autocomplete = true
vim.opt.complete = "o,.,w,b" -- omni func, current buffer, windows...
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup", "fuzzy", "noinsert" }
vim.opt.shortmess:append("c") -- reduce completion-related messages

vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.termguicolors = true

vim.o.mouse = "" -- disable mouse support
vim.o.pumheight = 15
vim.o.pumborder = "none"
vim.o.winborder = "single"

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing
vim.o.tabstop = 2 -- insert 2 spaces for a tab

vim.o.cursorline = false
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.numberwidth = 2 -- number column width (default 4)
vim.o.guicursor = ""

vim.o.wrap = false
vim.o.conceallevel = 1 -- so that `` is visible in markdown files
vim.o.laststatus = 3 -- always and ONLY the last window
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("state") .. "/undo"
vim.o.updatetime = 300 -- faster completion (4000ms default)

vim.o.colorcolumn = "100"
vim.o.virtualedit = "block" -- allow cursor in visual block empty areas
vim.o.exrc = true -- add .nvmrc
vim.o.secure = true -- not run unsafe cmds from .nvmrc

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

-- modify search and path behavior
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
vim.opt.iskeyword:append("-") -- treat hyphens as part of a word
