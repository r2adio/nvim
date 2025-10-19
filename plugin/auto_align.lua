local M = {}

-- Function to align table in visual line mode
function M.align_table()
	-- Get the start and end lines of the visual selection
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- Get the selected lines
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	if #lines == 0 then
		vim.notify("No lines selected for table alignment", vim.log.levels.ERROR)
		return
	end

	-- Split each line into columns
	local table_data = {}
	for i, line in ipairs(lines) do
		-- Split by |, trim whitespace from each cell
		local columns = vim.split(line, "|", { trimempty = true })
		for j, col in ipairs(columns) do
			columns[j] = col:match("^%s*(.-)%s*$") or ""
		end
		table_data[i] = columns
	end

	-- Calculate max width for each column
	local max_widths = {}
	for _, row in ipairs(table_data) do
		for col_idx, cell in ipairs(row) do
			max_widths[col_idx] = math.max(max_widths[col_idx] or 0, #cell)
		end
	end

	-- Rebuild lines with padded columns
	local new_lines = {}
	for _, row in ipairs(table_data) do
		local new_row = {}
		for col_idx, cell in ipairs(row) do
			-- Pad with spaces to match max width, add 1 extra space for readability
			local padding = string.rep(" ", max_widths[col_idx] - #cell + 1)
			new_row[#new_row + 1] = "|" .. cell .. padding
		end
		new_row[#new_row + 1] = "|" -- Add final pipe
		-- Use table.concat with explicit table module
		new_lines[#new_lines + 1] = table.concat(new_row, "")
	end

	-- Update the buffer with new lines
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
end

-- Create user command
vim.api.nvim_create_user_command("AlignTable", function()
	M.align_table()
end, { range = true })

return M
