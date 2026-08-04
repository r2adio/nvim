vim.pack.add({ "gh:mfussenegger/nvim-dap", "gh:igorlfs/nvim-dap-view" })

local dap = require("dap")
dap.adapters.codelldb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
	name = "lldb",
}
dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
dap.configurations.cpp = vim.deepcopy(dap.configurations.c)
dap.configurations.rust = {
	{
		name = "Launch (cargo run)",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
dap.adapters.debugpy = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/debugpy",
	args = { "--listen", "127.0.0.1:0", "--wait-for-client", "--install-adapter" },
}
dap.configurations.python = {
	{
		type = "debugpy",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return vim.fn.input(
				"Path to python interpreter: ",
				vim.fn.exepath("python3") or "python3",
				"file"
			)
		end,
	},
}
