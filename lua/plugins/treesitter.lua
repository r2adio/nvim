vim.pack.add({ "gh:nvim-treesitter/nvim-treesitter" })

require("nvim-treesitter").setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

local lang = { "typescript", "python", "http" }
local extras = { "yaml", "json", "nix" }
local parsers = vim.list_extend(vim.deepcopy(lang), extras)

require("nvim-treesitter").install(parsers)
