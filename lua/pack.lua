-- plugins urls
vim.pack.add({ "gh:stevearc/conform.nvim" })
vim.pack.add({ "gh:mfussenegger/nvim-lint" })
vim.pack.add({ "gh:nvim-treesitter/nvim-treesitter" })

-- plugin w/o configs
vim.pack.add({ "gh:justinmk/guh.nvim" })
vim.pack.add({ "gh:tpope/vim-fugitive" })
vim.pack.add({ "gh:tpope/vim-surround" })
vim.pack.add({ "gh:justinmk/vim-dirvish" })
vim.pack.add({ "gh:nvim-orgmode/orgmode" })
vim.pack.add({ "gh:tpope/vim-dadbod", "gh:kristijanhusak/vim-dadbod-completion" })

-- local plugin
-- vim.pack.add({ ("file://%s/projects/exec.nvim"):format(vim.env.HOME) })

-- configurations
require("pack.lint")
require("pack.conform")
require("pack.treesitter")
