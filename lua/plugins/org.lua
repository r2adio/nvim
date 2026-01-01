require("orgmode").setup({
  org_agenda_files = { "~/org/**/*", "~/orgfiles/work.org", "~/orgfiles/personal.org" },
  org_default_notes_file = "~/org/todo.org",

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
