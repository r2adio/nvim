local M = {}

-- We'll store files in a Lua table (linked to Vim's arglist)
M.files = {}

-- Helper: Refresh arglist to match M.files
local function update_arglist()
	vim.cmd("args " .. table.concat(M.files, " "))
end

-- Add current file to list
function M.add_file()
	local file = vim.fn.expand("%:p")
	if file == "" then
		print("No file to add.")
		return
	end

	for _, f in ipairs(M.files) do
		if f == file then
			print("File already added: " .. file)
			return
		end
	end

	table.insert(M.files, file)
	-- update_arglist()
	print("Added: " .. file)
end

-- Show files in a floating window
function M.show_list()
	if #M.files == 0 then
		print("No files added yet.")
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.3)
	local height = math.min(#M.files + 2, math.floor(vim.o.lines * 0.5))
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
		title = "Argpoon",
		title_pos = "left",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_buf_set_option(buf, "modifiable", true)

	local lines = {}
	for i, f in ipairs(M.files) do
		table.insert(lines, string.format("%d. %s", i, vim.fn.fnamemodify(f, ":.")))
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)

	-- Keymaps for navigation
	vim.keymap.set("n", "<CR>", function()
		local line = vim.fn.line(".")

		vim.api.nvim_win_close(win, true)
		vim.cmd("edit " .. M.files[line])
	end, { buffer = buf, nowait = true })

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, nowait = true })
end

-- Remove current file from list
function M.remove_file()
	local file = vim.fn.expand("%:p")
	for i, f in ipairs(M.files) do
		if f == file then
			table.remove(M.files, i)
			update_arglist()
			print("Removed: " .. file)
			return
		end
	end
	print("File not found in list: " .. file)
end

-- Clear all files
function M.clear_list()
	M.files = {}
	vim.cmd("args")
	print("Cleared all files.")
end

vim.keymap.set("n", "<leader>aa", M.add_file, { desc = "Add current file" })
vim.keymap.set("n", "<leader>as", M.show_list, { desc = "Show added files" })
vim.keymap.set("n", "<leader>ax", M.remove_file, { desc = "Remove current file" })
vim.keymap.set("n", "<leader>ac", M.clear_list, { desc = "Remove current file" })
return M
