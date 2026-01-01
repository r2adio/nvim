local sources = {
  default = { "lsp", "path", "snippets", "buffer" },

  per_filetype = {
    org = { "orgmode", "buffer" },
  },

  providers = {
    orgmode = {
      name = "Orgmode",
      module = "orgmode.org.autocompletion.blink",
      score_offset = 75,
    },
  },
}

require("blink.cmp").setup({
  keymap = { preset = "default" },

  appearance = { nerd_font_variant = "mono" },

  completion = {
    keyword = { range = "full" },
    documentation = { auto_show = true },
  },

  signature = {
    enabled = true,
    window = {
      border = "single",
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

