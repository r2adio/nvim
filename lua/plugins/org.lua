vim.pack.add({ "gh:nvim-orgmode/orgmode" })

local LinkPingType = {}
function LinkPingType:get_name()
	return "ping"
end
function LinkPingType:follow(link)
	if not vim.startswith(link, "ping:") then
		return false
	end
	-- Get the part after the `ping:` part
	local url = link:sub(6)
	-- Open terminal in vertical split and ping the URL
	vim.cmd("vsplit | term ping " .. url)
	return true
end
function LinkPingType:autocomplete(link)
	local items = {
		"ping:google.com",
		"ping:github.com",
	}
	return vim.tbl_filter(function(item)
		return vim.startswith(item, link)
	end, items)
end

require("orgmode").setup({
	org_agenda_files = { "~/org/**/*", "~/orgfiles/work.org", "~/orgfiles/personal.org" },
	org_default_notes_file = "~/org/todo.org",

	hyperlinks = {
		sources = {
			LinkPingType,
			{
				get_name = function()
					return "my_custom_type"
				end,
				follow = function(self, link)
					print("Following link:", link)
					return true
				end,
				autocomplete = function(self, link)
					return { "my_custom_type:my_custom_link" }
				end,
			},
		},
	},

	org_capture_templates = {
		w = {
			description = "Work task",
			template = "* TODO %?\n  SCHEDULED: %t",
			target = "~/org/work.org",
		},
		p = {
			description = "Personal task",
			template = "* TODO %?\n  SCHEDULED: %t",
			target = "~/org/personal.org",
		},
	},

	org_custom_agenda_views = {
		w = {
			description = "Work agenda",
			agenda = { files = { "~/or/work.org" } },
		},
		p = {
			description = "Personal agenda",
			agenda = { files = { "~/org/personal.org" } },
		},
	},
})
