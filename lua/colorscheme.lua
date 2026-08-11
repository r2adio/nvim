-- vim.g.gruvbox_material_enable_bold = 1
-- vim.g.gruvbox_material_enable_italic = 1
-- vim.g.gruvbox_material_background = "hard" -- hard | soft
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_foreground = "material" -- original | material
-- vim.g.gruvbox_material_statusline_style = "mix"
-- vim.g.gruvbox_material_transparent_background = 2
-- vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
-- vim.g.gruvbox_material_colors_override = { bg0 = { "#000000", "234" } }
-- vim.g.gruvbox_material_float_style = "dim" -- bright | dim | blend

vim.g.sonokai_style = "shusia"
vim.g.sonokai_better_performance = 1
vim.g.sonokai_enable_italic = true

vim.cmd.colorscheme("monotone")
-- monotone base16-ashes base16-tomorrow-night base16-grayscale-dark

local transparent_groups = {
	"Normal",
	"NormalNC",
	"NormalFloat",
	"EndOfBuffer",
	"FloatBorder",
	"SignColumn",
	"LineNr",
	"CursorLine",
	"CursorLineNr",
	"StatusLine",
	"StatusLineNC",
	"TabLine",
	"TabLineFill",
	"TelescopeNormal",
	"TelescopeBorder",
	"ToggleTermNormal",
	"ToggleTermNormalFloat",
}
local function apply_transparency()
	for _, group in ipairs(transparent_groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.bg = nil
		hl.ctermbg = nil
		vim.api.nvim_set_hl(0, group, hl)
	end
end
apply_transparency()
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", callback = apply_transparency })
