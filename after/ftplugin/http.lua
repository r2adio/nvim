local ts = vim.treesitter
local api = vim.api

local function format_json(output)
	local lines = vim.split(output, "\n")
	local i = 1
	while lines[i] and lines[i] ~= "" do
		i = i + 1
	end
	if i > #lines then
		return lines
	end
	local body = table.concat(vim.list_slice(lines, i + 1), "\n")
	local ok, json = pcall(vim.json.decode, body)
	if not ok or json == nil then
		return lines
	end
	lines = vim.list_slice(lines, 1, i)
	vim.list_extend(lines, vim.split(vim.json.encode(json, { indent = "  " }), "\n"))
	return lines
end

local function run()
	local parser = ts.get_parser(0, "http")
	local root = parser:parse()[1]:root()

	local pos = api.nvim_win_get_cursor(0)
	local node = root:named_descendant_for_range(pos[1] - 1, pos[2], pos[1] - 1, pos[2])

	while node and node:type() ~= "section" do
		node = node:parent()
	end
	if not node then
		vim.notify("No HTTP request under cursor", vim.log.levels.WARN)
		return
	end

	local request
	for _, child in ipairs(node:named_children()) do
		if child:type() == "request" then
			request = child
			break
		end
	end
	if not request then
		vim.notify("No HTTP request in this section", vim.log.levels.WARN)
		return
	end

	local method = request:field("method")[1]
	local url = request:field("url")[1]
	if not method or not url then
		vim.notify("Request is missing method or URL", vim.log.levels.WARN)
		return
	end
	url = ts.get_node_text(url, 0)

	local cmd = { "curl", "-isS", "-X", ts.get_node_text(method, 0) }
	local host
	for _, header in ipairs(request:field("header")) do
		local name = header:field("name")[1]
		local value = header:field("value")[1]
		if name and value then
			name = ts.get_node_text(name, 0)
			value = ts.get_node_text(value, 0)
			table.insert(cmd, "-H")
			table.insert(cmd, name .. ": " .. value)
			if name == "Host" then
				host = value
			end
		end
	end

	local body = request:field("body")[1]
	if body then
		table.insert(cmd, "--data-binary")
		table.insert(cmd, ts.get_node_text(body, 0))
	end

	if url:sub(1, 1) == "/" then
		if not host then
			vim.notify("Relative URL requires a Host header", vim.log.levels.WARN)
			return
		end
		url = "http://" .. host .. url
	end

	table.insert(cmd, url)

	vim.system(cmd, { text = true }, function(res)
		local output = res.stdout
		if output == "" then
			output = res.stderr
		end
		output = output:gsub("\r\n", "\n")

		vim.schedule(function()
			vim.cmd("botright new")
			vim.bo.buftype = "nofile"
			vim.bo.bufhidden = "wipe"
			vim.bo.swapfile = false
			api.nvim_buf_set_lines(0, 0, -1, false, format_json(output))
			vim.bo.modifiable = false
			vim.bo.readonly = true
		end)
	end)
end

vim.keymap.set("n", "<CR>", run, { buffer = true, silent = true })
