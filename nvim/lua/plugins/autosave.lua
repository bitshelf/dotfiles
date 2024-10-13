return {
	"okuuva/auto-save.nvim",
	event = { "WinLeave" },
	-- event = "LazyFile",
	opts =  {
		--  execution_message = {
		--   enabled = false,
		--   message = function() -- message to print on save
		-- 	return (" ")
		--   end,
		-- },
		trigger_events = { -- See :h events
		  immediate_save = { "WinLeave", "BufLeave", "FocusLost" },
		  defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
		  cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
		},
		write_all_buffers = false, -- write all buffers when the current one meets `condition`
		noautocmd = false, -- do not execute autocmds when saving
		debounce_delay = 1000,
	},

	-- {
	--   '0x00-ketsu/autosave.nvim',
	--   -- lazy-loading on events
	--   event = { "InsertLeave", "TextChanged" },
	--   config = function()
	-- 	require('autosave').setup {
	-- 	 prompt_message = function()
 --          return ''
	-- 	end,
 --        events = { "TermOpen" },
 --        conditions = {
 --            exists = true,
 --            modifiable = true,
 --            filename_is_not = {},
 --            filetype_is_not = {}
 --        },
	--   }
	--   end
	-- }
}
