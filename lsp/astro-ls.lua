local function get_typescript_server_path(root_dir)
	local tsdk = root_dir .. "/node_modules/typescript/lib"
	local stat = vim.uv.fs_stat(tsdk)
	if stat and stat.type == "directory" then
		return tsdk
	end
	return nil
end

return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	init_options = {
		typescript = {},
	},
	before_init = function(_, config)
		local tsdk = get_typescript_server_path(config.root_dir)
		if not tsdk then
			return false -- skip initialization
		end
		config.init_options.typescript.tsdk = tsdk
	end,
}
