-- TODO: make the side buffer savable. add header to side buffer with some info (file, path, date, nr of todos,...)
vim.cmd("highlight default link TodoIndexHighlightText Type")
vim.cmd("highlight default link TodoIndexHighlightHeader Function")
local buffParser = require('buffParser')
-- local picker = require('TelescopePicker')
local augroup = vim.api.nvim_create_augroup("todoIndex", {clear = true})
local M = {}

-- function M.collect()
-- 	local todos, lines = buffParser.parseWithTreesitter(0)
-- 	if not todos or #todos == 0 or not lines or not #lines == 0 then
-- 		print("no TODOS")
-- 		return
-- 	end
-- 	local out = {}
-- 	local header = {}
-- 	local text = {}
-- 	for idx, todo in ipairs(todos) do
-- 		local head = string.format(
-- 			"TODO %d - line %d - %d: ",
-- 			idx,
-- 			lines[idx][1],
-- 			lines[idx][2]
-- 		)
-- 		table.insert(out, head)
-- 		table.insert(header, head)

-- 		for line in todo:gmatch("[^\r\n]+") do
-- 			if line:match("TODO") then
-- 				table.insert(text, line)
-- 			end
-- 		end
-- 		for line in todo:gmatch("[^\r\n]+") do
-- 			local cleaned = line:match("TODO:?%s*(.*)")
-- 			if not cleaned then
-- 				cleaned = line
-- 			end
-- 			cleaned = cleaned:gsub("//", "")
-- 			cleaned = cleaned:gsub("/%*", "")
-- 			cleaned = cleaned:gsub("%*/", "")
-- 			cleaned = cleaned:match("^%s*(.-)%s*$")
-- 			if not cleaned:match("%S") then
-- 				goto continue
-- 			end
-- 			cleaned = ">>>	" .. cleaned
-- 			table.insert(out, cleaned or line)
-- 			::continue::
-- 		end
-- 		table.insert(out, "") -- separator
-- 	end
-- end

function M.test()
	local out, _, _ = buffParser.collect()
	if not out or #out == 0 then
		print("no TODOS")
		return
	end

	vim.cmd("vnew")
	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
	vim.api.nvim_buf_set_option(buf, "filetype", "todoindex")

	vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
	local ns = vim.api.nvim_create_namespace("todoindex_highlight")
	for i, line in ipairs(out) do
		if line:find(">>>") then
			vim.api.nvim_buf_add_highlight(buf, ns, "TodoIndexHighlightText", i-1, 0, -1)
		elseif line:find("TODO") then
			vim.api.nvim_buf_add_highlight(buf, ns, "TodoIndexHighlightHeader", i-1, 0, -1)
		end
	end
end

-- function M.todoPicker()
-- 	picker.TodoPicker()
-- end

function M.todoPicker()
  -- lazy require to avoid require-time errors / circular requires
  local ok, picker = pcall(require, "todoIndex.TelescopePicker") -- or "TelescopePicker" depending on path
  if not ok then
    -- fallback: try plain name or show a helpful message
    local ok2, picker2 = pcall(require, "TelescopePicker")
    if not ok2 then
      vim.notify("todoIndex: could not load TelescopePicker: "..tostring(picker), vim.log.levels.WARN)
      return
    end
    picker = picker2
  end

  if type(picker.TodoPicker) ~= "function" then
    vim.notify("todoIndex: picker missing TodoPicker function", vim.log.levels.WARN)
    return
  end

  picker.TodoPicker()
end

function M.main()
	local out, _, _ = buffParser.collect()
	if not out or #out == 0 then
		print("no TODOS")
		return
	end

	vim.cmd("vnew")
	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
	vim.api.nvim_buf_set_option(buf, "filetype", "todoindex")

	vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
	local ns = vim.api.nvim_create_namespace("todoindex_highlight")
	for i, line in ipairs(out) do
		if line:find(">>>") then
			vim.api.nvim_buf_add_highlight(buf, ns, "TodoIndexHighlightText", i-1, 0, -1)
		elseif line:find("TODO") then
			vim.api.nvim_buf_add_highlight(buf, ns, "TodoIndexHighlightHeader", i-1, 0, -1)
		end
	end
end



function M.setup()
	vim.api.nvim_create_user_command("TodoIndex", function()
		M.main()
	end, {})
	vim.api.nvim_create_user_command("TodoIndexPicker", function()
		M.todoPicker()
	end, {})
end

return M
