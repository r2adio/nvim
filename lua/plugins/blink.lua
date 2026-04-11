vim.pack.add({
	{ src = "gh:Saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "gh:rafamadriz/friendly-snippets" },
})

local sources = {
	default = { "lsp", "path", "snippets", "buffer" },

	per_filetype = {
		org = { "orgmode", "buffer" },
		sql = { "snippets", "dadbod", "buffer" },
	},

	providers = {
		orgmode = {
			name = "Orgmode",
			module = "orgmode.org.autocompletion.blink",
			score_offset = 75,
		},
		dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
	},
}

require("blink.cmp").setup({
	keymap = { preset = "default", ["<C-k>"] = { "fallback" } },

	appearance = { nerd_font_variant = "mono" },

	completion = {
		-- ghost_text = { enabled = true, show_with_selection = true },
		keyword = { range = "full" },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			border = "",
			draw = { columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } } },
		},
	},

	signature = {
		enabled = true,
		window = {
			show_documentation = true,
		},
	},

	sources = sources,

	snippets = { preset = "default" },

	fuzzy = {
		implementation = "prefer_rust_with_warning",
		prebuilt_binaries = {
			force_version = "v1.8.0",
		},
	},
})
