local fzf = require("fzf-lua")
local utils = require("fzf-lua.utils")

local function get_readme(path)
	if type(path) ~= "string" or path == "" then
		return ""
	end
	for _, file in ipairs({ "README.md", "README" }) do
		local full = path .. "/" .. file
		if vim.fn.filereadable(full) == 1 then
			return full
		end
	end
	return path
end

local function run_pack_manager(only_non_active)
	local lockfile_path = vim.fn.stdpath("config") .. "/nvim-pack-lock.json"
	if vim.fn.filereadable(lockfile_path) == 0 then
		return vim.notify("nvim-pack-lock.json not found", vim.log.levels.ERROR)
	end

	local lock_data = vim.json.decode(table.concat(vim.fn.readfile(lockfile_path), "\n"))
	if not lock_data or not lock_data.plugins then
		return vim.notify("No plugins found in lockfile", vim.log.levels.WARN)
	end

	-- install plugins table
	local pack_info = {}
	for _, p in ipairs(vim.pack.get()) do
		pack_info[p.spec.name] = p
	end

	local entries, entry_to_name = {}, {}

	for name, info in pairs(lock_data.plugins) do
		local p = pack_info[name] or {}

		if not only_non_active or not p.active then
			local rev = utils.ansi_codes.green((info.rev or ""):sub(1, 7))
			local disp = utils.ansi_codes.blue(name)
			local entry = string.format("%s:1:1:[%s]  %s", get_readme(p.path), rev, disp)

			table.insert(entries, entry)
			entry_to_name[utils.strip_ansi_coloring(entry)] = name
		end
	end

	if #entries == 0 then
		return vim.notify("No plugins to display", vim.log.levels.INFO)
	end

	local function get_name(sel)
		if not sel or not sel[1] then
			return nil
		end
		return entry_to_name[utils.strip_ansi_coloring(sel[1])]
	end

	fzf.fzf_exec(entries, {
		prompt = "Vim.pack> ",
		previewer = "builtin",
		fzf_opts = {
			["--delimiter"] = ":",
			["--with-nth"] = "4..",
			["--tiebreak"] = "begin",
		},
		actions = {
			["default"] = function(sel)
				local name = get_name(sel)
				local p = name and pack_info[name]
				if p and p.path and p.path ~= "" then
					vim.cmd("edit " .. vim.fn.fnameescape(p.path))
				end
			end,
			["ctrl-u"] = function(sel)
				local name = get_name(sel)
				if name then
					vim.pack.update({ name })
				end
			end,
			["ctrl-d"] = function(sel)
				local name = get_name(sel)
				if not name then
					return
				end

				local p = vim.iter(vim.pack.get()):find(function(x)
					return x.spec.name == name
				end)

				if not p then
					vim.notify("Plugin not found on disk: " .. name, vim.log.levels.WARN)
				elseif p.active then
					vim.notify("Cannot delete active plugin: " .. name, vim.log.levels.ERROR)
				else
					vim.pack.del({ name })
					vim.notify("Deleted: " .. name, vim.log.levels.INFO)
				end
			end,
		},
	})
end

vim.api.nvim_create_user_command("Pack", function()
	run_pack_manager(false)
end, {})
vim.api.nvim_create_user_command("PackNonActive", function()
	run_pack_manager(true)
end, {})
