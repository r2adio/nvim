function _G.GetGitBranch()
	local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
	if handle then
		local branch = handle:read("*a"):gsub("[\n\r]", "")
		handle:close()
		if #branch > 0 then
			return "   " .. branch .. " "
		end
	end
	return ""
end

-- filename, modified[+], read-only{RO}, help-file{HLP}, preview{PREVIEW}, filetype, current-line, total-lines, position
vim.opt.statusline = "%{v:lua.GetGitBranch()} %f %m%r%h%w %= %y %l/%L     %P"
