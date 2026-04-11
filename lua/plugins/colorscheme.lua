vim.pack.add({ "gh:sainnhe/gruvbox-material" })

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_statusline_style = "mix"
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_colors_override = { bg0 = { "#000000", "234" } }
vim.g.gruvbox_material_float_style = "dim" -- bright | dim | blend
vim.cmd("colorscheme gruvbox-material")
