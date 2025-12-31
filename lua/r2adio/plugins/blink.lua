return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", "nvim-orgmode/orgmode" },

	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "default" },

		appearance = { nerd_font_variant = "mono" },

		completion = {
			keyword = { range = "full" }, -- "prefix", "full"
			documentation = { auto_show = true },
			-- ghost_text = { enabled = true },
		},

		signature = {
			enabled = true,
			window = { border = "single", show_documentation = true },
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },

			per_filetype = { org = { "orgmode", "buffer" } },
			providers = {
				orgmode = {
					name = "Orgmode",
					module = "orgmode.org.autocompletion.blink",
					score_offset = 75,
				},
			},
		},

		snippets = { preset = "default" },

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
