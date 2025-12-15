local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorter = require("telescope.sorters").get_generic
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"
local previewers = require "telescope.previewers"
local buffParser = require("buffParser")

local bufname = vim.api.nvim_buf_get_name(0)
local todos, headers, texty = buffParser.collect()
headers = headers or {"nothing"}
texty = texty or {"nothing"}
local M = {}

-- buffParser.test()

local entries = {}
for i = 1, #headers do
	local lnum1, lnum2 = headers[i]:match("line (%d+)%s*%-[%s]*(%d+)")
	lnum1 = tonumber(lnum1)
	lnum2 = tonumber(lnum2) or lnum1
	table.insert(entries, {
		filename = bufname,
		lnum = lnum1 or 1,
		end_lnum = lnum2 or lnum1 or 1,
		header = headers[i],
		text = texty[i] or ""
	})
end

function M.TodoPicker()
	local displayer = entry_display.create {
		separator = " │ ",
		items = {
			{ width = 30 }, -- header column width
			{ remaining = true }, -- text column
		},
	}
	local todoPicker = function(opts)
		opts = opts or {}
		pickers.new(opts, {
			prompt_title = "TODOs",
			finder = finders.new_table {
				results = entries,
				entry_maker = function(entry)
					return {
						value = entry,
						display = function(e)
							return displayer {
								{ e.header, "telescopeResultsIdentifier" },
								{ e.text, "telescopeResultsComment" },
							}
						end,
						ordinal = entry.text .. " " .. entry.text,
						header = entry.header,
						text = entry.text
					}
				end
			},
			sorter = conf.generic_sorter(opts),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry, status)
					local buffer_previewer_maker = require('telescope.config').values.buffer_previewer_maker
					buffer_previewer_maker(entry.value.filename, self.state.bufnr, {
						bufname = self.state.bufname,
						callback = function(bufnr)
							vim.api.nvim_buf_call(bufnr, function()
								-- Move cursor to the TODO line in the preview window
								if self.state.winid and entry.value.lnum then
									vim.api.nvim_win_set_cursor(self.state.winid, {entry.value.lnum, 0})
									vim.api.nvim_set_current_win(self.state.winid)
									vim.cmd("normal! zz")
									-- Optionally highlight the line
									for i = entry.value.lnum, entry.value.end_lnum do
										vim.api.nvim_buf_add_highlight(bufnr, -1, "Visual", i, 0, -1)
									end
								end
							end)
						end,
					})
				end
			}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local currBuf = vim.fn.bufnr(selection.value.filename, true)
					print (currBuf)
					vim.api.nvim_set_current_buf(currBuf)
					vim.api.nvim_win_set_cursor(0, {selection.value.lnum + 1, 0})
				end)
				return true
			end,
		}):find()
	end

	todoPicker()
end

M.TodoPicker()

return M
