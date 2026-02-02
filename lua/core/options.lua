-- vim.g.python3_host_prog = os.getenv("HOME") .. ".pyenv/versions/3.12.3/bin/python" -- python code environment

local options = {
	-- :help options
	nu = true, -- enable line numbers
	relativenumber = true, -- relative line numbers
	-- list = true, -- Show some invisible characters (tabs...)
	backup = false, -- creates a backup file
	-- clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menu", "menuone", "noselect", "preview", "fuzzy" }, -- mostly just for cmp
	conceallevel = 2, -- so that `` is visible in markdown files
	encoding = "utf-8", -- set encoding
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	incsearch = true, -- show search results as you type
	ignorecase = true, -- ignore case in search patterns
	mouse = "", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = true, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 1, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	-- splitbelow = true, -- force all horizontal splits to go below current window
	-- splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	softtabstop = 2, -- Number of spaces that a <Tab> counts for while editing
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = true, -- display lines as one long line
	linebreak = true, --wraps lines at word boundaries
	scrolloff = 8, -- will always keep 8 lines of context
	sidescrolloff = 8,
	-- guifont = "JetBrainsMono Nerd Font:h17", -- the font used in graphical neovim applications
	guicursor = "",
	colorcolumn = "100",
	winborder = "single",

	-- grep options
	grepprg = "rg --vimgrep --no-heading --smart-case --hidden --glob '!.git'",
	grepformat = "%f:%l:%c:%m",

	-- find options
	path = vim.opt.path:append("**"),
	wildmenu = true,
	wildmode = "longest:full,full",
	wildignorecase = true,
	wildignore = vim.opt.wildignore:append({
		"*/node_modules/*",
		"*/dist/*",
		"*/build/*",
		"*/.git/*",
		"*/.cache/*",
		"*/.next/*",
		"*.log",
	}),

	-- filename, modified[+], read-only{RO}, help-file{HLP}, preview{PREVIEW}, filetype, current-line, total-lines, position
	statusline = "%{v:lua.git_branch()} %f %m%r%h%w %= %#yellow#%{v:lua.wpm_get()}%* %y %l/%L     %P",
	-- statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s",
}

-- undotree settings
vim.g.undotree_WindowLayout = 4
vim.g.undotree_SplitWidth = 44

-- netrw settings
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

vim.api.nvim_set_hl(0, "yellow", { fg = "#d5c4a1", bold = true })

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd("set whichwrap+=<,>,[,]")
vim.cmd([[set iskeyword+=-]]) -- treat hyphens as part of a word

-- Change the Diagnostic symbols in the sign column (gutter)
vim.diagnostic.config({
	signs = {
		text = {
			-- [vim.diagnostic.severity.ERROR] = " ",
			-- [vim.diagnostic.severity.WARN] = " ",
			-- [vim.diagnostic.severity.HINT] = "󰠠 ",
			-- [vim.diagnostic.severity.INFO] = " ",
		},
	},
})

vim.diagnostic.config({
	-- virtual_lines = { current_line = true },
	virtual_text = { current_line = true },
	float = { border = "rounded" },
	update_in_insert = false,
	severity_sort = true,
})

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
			semanticTokens = { multilineTokenSupport = true },
		},
	},
}) -- adding capabilities to vim.lsp
