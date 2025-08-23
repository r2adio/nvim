function _G.git_branch()
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
