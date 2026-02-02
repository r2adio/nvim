local M = {}

-- We'll store files in a Lua table (linked to Vim's arglist)
M.files = {}

local function update_arglist()
	vim.cmd("args " .. table.concat(M.files, " "))
end

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

function M.show_list()
	if #M.files == 0 then
		print("No files added yet.")
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.20)
	local height = math.min(#M.files + 1, math.floor(vim.o.lines * 0.5))
	local row = math.floor((vim.o.lines - height) / 1.1)
	local col = math.floor((vim.o.columns - width) / 1)

	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
		title = " Argpoon ",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

	local lines = {}
	for i, f in ipairs(M.files) do
		table.insert(lines, string.format("%d. %s", i, vim.fn.fnamemodify(f, ":.")))
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

	vim.api.nvim_create_autocmd("BufWinLeave", {
		buffer = buf,
		once = true,
		callback = function()
			lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

			M.files = {}
			for _, line in ipairs(lines) do
				local path = line:match("^%d+%.%s+(.*)$")
				if path and path ~= "" then
					table.insert(M.files, vim.fn.fnamemodify(path, ":p"))
				end
			end
		end,
	})

	vim.keymap.set("n", "<CR>", function()
		local line = vim.fn.line(".")

		vim.api.nvim_win_close(win, true)
		vim.cmd("edit " .. M.files[line])
	end, { buffer = buf, nowait = true })

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, nowait = true })
end

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

function M.open_file_by_index(index)
	if type(index) ~= "number" or index <= 0 or index > #M.files then
		print("Invalid index: " .. tostring(index) .. ". Use 1-" .. #M.files)
		return
	end

	local file = M.files[index]
	vim.cmd("edit " .. file)
	print("Opened: " .. vim.fn.fnamemodify(file, ":."))
end

function M.prompt_and_open()
	if #M.files == 0 then
		print("No files added yet.")
		return
	end

	local input = vim.fn.input("Open file by index (1-" .. #M.files .. "): ")
	if input == "" then
		return
	end

	local index = tonumber(input)
	M.open_file_by_index(index)
end

function M.clear_list()
	M.files = {}
	vim.cmd("args")
	print("Cleared all files.")
end

vim.keymap.set("n", "<leader>aa", M.add_file, { desc = "Add current file" })
vim.keymap.set("n", "<leader>as", M.show_list, { desc = "Show added files" })
vim.keymap.set("n", "<leader>ax", M.remove_file, { desc = "Remove current file" })
vim.keymap.set("n", "<leader>ac", M.clear_list, { desc = "Remove all files" })
vim.keymap.set("n", "<leader>an", M.prompt_and_open, { desc = "Open file by index" })

vim.api.nvim_create_user_command("ArgpoonOpen", function(opts)
	M.open_file_by_index(tonumber(opts.args))
end, {
	nargs = 1,
	complete = function()
		local indices = {}
		for i = 1, #M.files do
			table.insert(indices, tostring(i))
		end
		return indices
	end,
})

return M
