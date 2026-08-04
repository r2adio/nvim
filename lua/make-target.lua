--- @module 'blink.cmp'

local task_ok, task = pcall(function()
	return require("blink.cmp.lib.async").task
end)

if not task_ok then
	task = require("blink.lib.task")
end

--- @class blink-cmp-make.Options
--- @field item_kind? uinteger

--- @class MakeSource : blink.cmp.Source
--- @field opts blink-cmp-make.Options
--- @field completion_items blink.cmp.CompletionItem[]
--- @field cached_file string|nil
--- @field cached_mtime number|nil
local M = {}

--- @return MakeSource
function M.new()
	local self = setmetatable({}, { __index = M })
	self.completion_items = {}
	self.cached_file = nil
	self.cached_mtime = nil
	return self
end

--- @return string[]
function M:get_trigger_characters()
	return {}
end

--- Parse Makefile and extract targets
function M:setup_completion_items()
	local makefile = vim.fn.getcwd() .. "/Makefile"

	if vim.fn.filereadable(makefile) ~= 1 then
		self.completion_items = {}
		return
	end

	local stat = vim.uv.fs_stat(makefile)
	if stat then
		local mtime = stat.mtime.sec
		if self.cached_file == makefile and self.cached_mtime == mtime then
			return
		end
		self.cached_mtime = mtime
	end

	self.completion_items = {}
	self.cached_file = makefile

	local lines = vim.fn.readfile(makefile)
	local seen = {}

	for _, line in ipairs(lines) do
		local target = line:match("^([%w_%-%./]+)%s*:")
		if target and not seen[target] then
			seen[target] = true
			table.insert(self.completion_items, {
				label = target,
				insertText = target,
				insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
				kind = require("blink.cmp.types").CompletionItemKind.Method,
			})
		end
	end
end

--- @param callback fun(...: any)
--- @return fun()
function M:get_completions(_, callback)
	local chained_task = task.new(function()
		self:setup_completion_items()
		callback({
			is_incomplete_forward = false,
			is_incomplete_backward = false,
			items = self.completion_items,
		})
		return function() end
	end)

	return function()
		chained_task:cancel()
	end
end

return M
