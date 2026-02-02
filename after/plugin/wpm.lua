-- plugin/wpm.lua

-- Plugin state
local wpm_data = {
	chars_typed = 0,
	words_typed = 0,
	start_time = nil,
	last_time = nil,
	current_wpm = 0,
	reset_timer = nil,
	update_timer = nil,
}

-- Configuration
local config = {
	enable_on_startup = true,
	reset_after_idle = 5000, -- Reset after 5 seconds of inactivity
	update_interval = 3000, -- Update statusline every 3 second
	min_chars_for_calculation = 10, -- Minimum characters before calculating WPM
}

-- Forward declarations for local functions that call each other
local reset_wpm
local update_wpm
local reset_after_idle
local on_char_typed
local start_wpm

-- Reset statistics
reset_wpm = function()
	wpm_data.chars_typed = 0
	wpm_data.words_typed = 0
	wpm_data.start_time = vim.loop.hrtime()
	wpm_data.last_time = wpm_data.start_time
	wpm_data.current_wpm = 0
	-- vim.cmd("redrawstatus")
end

-- Update WPM calculation
update_wpm = function()
	if wpm_data.chars_typed < config.min_chars_for_calculation then
		wpm_data.current_wpm = 0
		return
	end

	local current_time = vim.loop.hrtime()
	local elapsed_minutes = (current_time - wpm_data.start_time) / 1e9 / 60

	if elapsed_minutes > 0 then
		wpm_data.current_wpm = math.floor(wpm_data.words_typed / elapsed_minutes)
	end
end

-- Reset after idle period
reset_after_idle = function()
	if wpm_data.reset_timer then
		wpm_data.reset_timer:stop()
		wpm_data.reset_timer:close()
	end

	wpm_data.reset_timer = vim.loop.new_timer()
	wpm_data.reset_timer:start(
		config.reset_after_idle,
		0,
		vim.schedule_wrap(function()
			reset_wpm()
			wpm_data.reset_timer = nil
		end)
	)
end

-- Handle character typed
on_char_typed = function()
	local current_time = vim.loop.hrtime()
	wpm_data.last_time = current_time
	wpm_data.chars_typed = wpm_data.chars_typed + 1

	-- Count words (approximate: every 5 characters = 1 word)
	wpm_data.words_typed = math.floor(wpm_data.chars_typed / 5)

	-- Cancel existing reset timer
	if wpm_data.reset_timer then
		wpm_data.reset_timer:stop()
		wpm_data.reset_timer:close()
		wpm_data.reset_timer = nil
	end
end

-- Start tracking
start_wpm = function()
	wpm_data.start_time = vim.loop.hrtime()
	wpm_data.last_time = wpm_data.start_time

	-- Set up autocmds for tracking typing
	vim.api.nvim_create_augroup("WPMTracker", { clear = true })

	-- Track character insertions
	vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
		group = "WPMTracker",
		callback = function()
			on_char_typed()
		end,
	})

	-- Reset on idle
	vim.api.nvim_create_autocmd({ "CursorHoldI", "CursorHold" }, {
		group = "WPMTracker",
		callback = function()
			reset_after_idle()
		end,
	})

	-- Update statusline periodically
	if wpm_data.update_timer then
		wpm_data.update_timer:stop()
		wpm_data.update_timer:close()
	end

	wpm_data.update_timer = vim.loop.new_timer()
	wpm_data.update_timer:start(
		0,
		config.update_interval,
		vim.schedule_wrap(function()
			update_wpm()
			-- vim.cmd("redrawstatus")
		end)
	)
end

-- Get current WPM for statusline (this is the function your statusline calls)
function _G.wpm_get()
	if wpm_data.current_wpm == 0 then
		return "WPM: --"
	end

	return string.format("WPM: %d", wpm_data.current_wpm)
end

-- Auto-start if enabled
if config.enable_on_startup then
	vim.defer_fn(function()
		start_wpm()
	end, 100)
end
