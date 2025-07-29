return {
	"mbbill/undotree",

	vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true, desc = "Open UndoTree" }),
}
