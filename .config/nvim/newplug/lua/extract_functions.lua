local utils = require('utils')
local telescope = require('telescope.builtin')
local F = {}

-- FUNCTION Extracts all the function names from the current buffer/file
function F.extract_functions(bufnr)
  -- local ts_utils = require'nvim-treesitter.ts_utils'
  local parser = vim.treesitter.get_parser(bufnr)
  local tree = parser:parse()[1]
  local root = tree:root()

  local function_names = {}

  local function traverse(node)
    if node:type() == "function_definition" then
      local name_node = node:child(1)
      if name_node then
		local prev_node = name_node:prev_sibling()
		local curr_text = vim.treesitter.get_node_text(name_node, bufnr)
		if prev_node then
			local prev_text = vim.treesitter.get_node_text(prev_node, bufnr)
			local cat_text = utils.concatPretty(prev_text, curr_text)
			table.insert(function_names, cat_text)
		else
			table.insert(function_names, curr_text)
		end
      end
    end
    for child in node:iter_children() do
      traverse(child)
    end
  end

  traverse(root)
  return function_names
end

-- FUNCTION Traverse all the files in the current directory recursively
function F.traverse_files()
	local files = vim.fn.globpath(vim.fn.getcwd(), "**/*.c", true, true)
	if #files == 0 then
		print("No .c files found")
	end
	local file_names = {}
	for _, file in ipairs(files) do
		table.insert(file_names, file)
	end
	return file_names
end

-- FUNCTION Highlight the function names and directories
local function highlight_insertion(new_bufnr, highlights)
	local is_file = false
	local is_dir = false
	local markers_inserted = {}
	for i, highlight in ipairs(highlights) do
		vim.api.nvim_buf_add_highlight(new_bufnr, -1, highlight.type, highlight.line, 0, -1)
		if highlight.type == "Function" and is_dir == true then
			table.insert(markers_inserted, {line = highlight.line, text = "{{{"})
			is_dir = false
			is_file = true
		elseif highlight.type == "Directory" then
			if is_file == true then
				table.insert(markers_inserted, {line = highlight.line, text = "}}}"})
				is_file = false
			end
			is_dir = true
		end
	end
	return markers_inserted
end


-- FUNCTION this sets up the fold markers and conceal markers, and keybinds to open close them
local function marker_magic(new_bufnr)

	vim.api.nvim_buf_call(new_bufnr, function()
		-- Set fold method to marker
		vim.cmd('set foldmethod=marker')
		-- Define conceal syntax for fold markers
		vim.cmd('syn match FoldMarker /{{{/ conceal cchar=↳')
		vim.cmd('syn match  FoldMarker /}}}/ conceal cchar=↸')
		-- Set conceal options to hide fold markers
		vim.cmd('set conceallevel=2')
		vim.cmd('set concealcursor=nvic')
	end)


	-- set fold text
	_G.my_fold_text = function()
		local lines = vim.v.foldend - vim.v.foldstart - 1
		local fold_text = '↳\t\t\t' .. lines .. ' functions'
		return fold_text
	end
	vim.api.nvim_buf_call(new_bufnr, function()
		vim.cmd('setlocal foldtext=v:lua.my_fold_text()')
	end)

	-- Set up autocmd to handle cursor movement over concealed fold markers
	vim.api.nvim_buf_call(new_bufnr, function()
		vim.cmd([[
		augroup ConcealFoldMarker
		autocmd!
		autocmd CursorMoved,CursorMovedI * lua _G.check_concealed_fold_marker()
		augroup END
		]])
	end)

	-- Check if cursor is over a concealed fold marker and set keybinds accordingly
	_G.check_concealed_fold_marker = function()
		local line = vim.fn.getline('.')
		if line:find('↸') or line:find('}}}') then
			vim.api.nvim_buf_set_keymap(0, 'n', '<Left>', 'zc', { noremap = true, silent = true })
			vim.api.nvim_buf_set_keymap(0, 'n', '<Right>', 'zc', { noremap = true, silent = true })
			vim.api.nvim_buf_set_keymap(0, 'n', 'h', 'zc', { noremap = true, silent = true })
			vim.api.nvim_buf_set_keymap(0, 'n', 'l', 'zc', { noremap = true, silent = true })
		else
			pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<Left>')
			pcall(vim.api.nvim_buf_del_keymap, 0, 'n', '<Right>')
			pcall(vim.api.nvim_buf_del_keymap, 0, 'n', 'h')
			pcall(vim.api.nvim_buf_del_keymap, 0, 'n', 'l')
		end
	end
end

-- FUNCTION Open file and jump to function definition
local function open_file_and_jump(file_name, function_name)
  vim.cmd('edit ' .. file_name)
  vim.cmd('normal! gg')
  vim.cmd('normal! /' .. function_name)
end

-- FUNCTION Display all the function names in the current directory recursively
function F.display_functions()
	-- local bufnr = vim.api.nvim_get_current_buf()
	local files = F.traverse_files()
	local combined_names = {}
	local highlights = {}
	local function_mappings = {}

	-- traverse all the files from current dir recursively
	for _, file_name in ipairs(files) do
		table.insert(combined_names, file_name)
		table.insert(highlights, {line = #combined_names - 1, type = "Directory"})
		local file_buff = vim.api.nvim_create_buf(false, true)
		local file_content = vim.fn.readfile(file_name)

		--set filetype and buffer content
		vim.api.nvim_buf_set_lines(file_buff, 0, -1, false, file_content)
		local file_extension = vim.fn.fnamemodify(file_name, ":e")
		vim.api.nvim_buf_set_option(file_buff, "filetype", file_extension)

		-- traverse all function names in current buffer/file
		local function_names = F.extract_functions(file_buff)
		for _, function_name in ipairs(function_names) do
			table.insert(combined_names, function_name)
			table.insert(highlights, {line = #combined_names - 1, type = "Function"})
			table.insert(function_mappings, {file = file_name, function_name = function_name, line = #combined_names - 1})
		end

		-- delete the buffer
		vim.api.nvim_buf_delete(file_buff, {force = true})
	end

	-- Create a new buffer
	local new_bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, combined_names)
	vim.api.nvim_buf_set_option(new_bufnr, "filetype", "plaintext")

	-- Highlight the dirs and functions
	local markers_inserted = highlight_insertion(new_bufnr, highlights)

	-- Insert fold markers
	local i = 0
	for _, marker in ipairs(markers_inserted) do
		vim.api.nvim_buf_set_lines(new_bufnr, marker.line + i, marker.line + i, false, {marker.text})
		i = i + 1
	end

	for _, mapping in ipairs(function_mappings) do
		vim.api.nvim_buf_set_keymap(new_bufnr, 'n', '<CR>', string.format(":lua open_file_and_jump('%s', '%s')<CR>", mapping.file, mapping.function_name), { noremap = true, silent = true, nowait = true })
	end

	-- Open the new buffer in a new window
	vim.api.nvim_command('vsplit')
	vim.api.nvim_set_current_buf(new_bufnr)
	marker_magic(new_bufnr)

	return combined_names, new_bufnr
end

function F.find_functions()
  telescope.find_files({
	  prompt_title = "Find Functions",
	  finder = F.display_functions,
	  sorter = require'telescope.sorters'.values.generic_sorter({}), --get_fzy_sorter(),
  })
end


return F
