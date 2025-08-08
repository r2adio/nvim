return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- For icons in the file explorer
	},
	config = function()
		-- Disable netrw (Vim's built-in file explorer)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Import nvim-tree
		local nvimtree = require("nvim-tree")

		-- Function to calculate dynamic width
		local function calculate_width()
			return math.floor(vim.o.columns * 0.2) -- 20% of the screen width
		end

		-- Default settings for nvim-tree
		nvimtree.setup({
			-- General behavior
			auto_reload_on_write = true,
			disable_netrw = false,
			hijack_cursor = false,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = false,
			open_on_tab = false,
			sort_by = "name", -- Sort files by name
			view = {
				adaptive_size = false, -- Don't adjust size dynamically
				centralize_selection = false,
				cursorline = true, -- Highlight the current line
				debounce_delay = 15,
				side = "right", -- Position the file explorer on the right
				preserve_window_proportions = false,
				number = false, -- Disable line numbers
				relativenumber = false, -- Disable relative line numbers
				signcolumn = "yes", -- Show the sign column
				width = calculate_width(), -- Dynamically calculate width
				float = {
					enable = false, -- Disable floating window mode by default
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 30,
						height = 30,
						row = 1,
						col = 1,
					},
				},
			},
			renderer = {
				add_trailing = false, -- Don't add trailing slashes to directories
				group_empty = false, -- Don't group empty folders
				highlight_git = false, -- Disable Git status highlighting
				highlight_opened_files = "none", -- Don't highlight opened files
				root_folder_label = ":~:s?$?/..?", -- Display root folder label
				indent_markers = {
					enable = true, -- Enable indentation markers
					inline_arrows = true, -- Use inline arrows for indentation
					icons = {
						corner = "└",
						edge = "│",
						item = "─",
					},
				},
				icons = {
					git_placement = "after", -- Place Git indicators after filenames
					modified_placement = "before", -- Place modified indicators before filenames
					padding = " ", -- Add padding between icons and text
					symlink_arrow = " ➛ ", -- Symbol for symlinks
					show = {
						file = true, -- Show file icons
						folder = true, -- Show folder icons
						folder_arrow = true, -- Show folder arrows
						git = true, -- Show Git indicators
						modified = true, -- Show modified indicators
					},
					glyphs = {
						default = "", -- Default file icon
						symlink = "", -- Symlink file icon
						bookmark = "󰆤", -- Bookmark icon
						modified = "●", -- Modified indicator
						folder = {
							arrow_closed = "", -- Closed folder arrow
							arrow_open = "", -- Open folder arrow
							default = "", -- Default folder icon
							open = "", -- Open folder icon
							empty = "", -- Empty folder icon
							empty_open = "", -- Open empty folder icon
							symlink = "", -- Symlink folder icon
							symlink_open = "", -- Open symlink folder icon
						},
						git = {
							unstaged = "✗", -- Unstaged changes
							staged = "✓", -- Staged changes
							unmerged = "", -- Unmerged changes
							renamed = "➜", -- Renamed files
							untracked = "?", -- Untracked files
							deleted = "", -- Deleted files
							ignored = "◌", -- Ignored files
						},
					},
				},
			},
			hijack_directories = {
				enable = true, -- Hijack directory navigation
				auto_open = true, -- Automatically open the file explorer
			},
			update_focused_file = {
				enable = true, -- Update the file explorer when switching buffers
				update_root = false, -- Don't update the root directory
			},
			diagnostics = {
				enable = true, -- Enable diagnostic indicators
				show_on_dirs = true, -- Show diagnostics on directories
				icons = {
					hint = "", -- Hint diagnostic icon
					info = "", -- Info diagnostic icon
					warning = "", -- Warning diagnostic icon
					error = "", -- Error diagnostic icon
				},
			},
			filters = {
				dotfiles = false, -- Don't hide dotfiles
				custom = { "\\.pyc$", "__pycache__", "node_modules" }, -- Custom filters
			},
			git = {
				enable = true, -- Enable Git integration
				ignore = true, -- Ignore Gitignored files
			},
			actions = {
				open_file = {
					quit_on_open = false, -- Don't close the file explorer when opening a file
					resize_window = true, -- Resize the window when opening a file
				},
			},
			trash = {
				cmd = "gio trash", -- Command for deleting files
			},
		})

		-- Keybindings for nvim-tree
		local keymap = vim.keymap.set
		keymap("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
		keymap("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
		keymap("n", "<leader>o", function()
			if vim.bo.filetype == "NvimTree" then
				vim.cmd.wincmd("p") -- Jump back to the previous window (your file)
			else
				vim.cmd("NvimTreeFocus") -- Focus the file explorer
			end
		end, { silent = true, desc = "Toggle focus between file and NvimTree" })
	end,
}
