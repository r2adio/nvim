return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	filetypes = { "org" },
	config = function()
		require("orgmode").setup({
			org_agenda_files = "~/notes/**/*",
			org_default_notes_file = "~/notes/inbox.org",
		})
	end,
}
