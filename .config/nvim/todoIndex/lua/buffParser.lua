local M = {}

--parses for TODOs in where lines start with // or /* which doesn't work in all languages
function M.parse(_bufnr)
	local bufnr = _bufnr or 0
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false);
	local todos = {}
	local linePositions = {}
	local currLine = -1
local i = 1
	while i <= #lines do
		local line = lines[i]
		if line:find("TODO") and line:find("//") then
			local todo = {line}
			currLine = i
			-- i = i + 1
			-- while i <= #lines and lines[i]:find("^%s*//") do
			-- 	table.insert(todo, lines[i])
			-- 	i = i + 1
			-- end
			i = i + 1
			table.insert(todos, todo)
			table.insert(linePositions, currLine)
			currLine = -1
		elseif line:find("TODO") and i > 1 and lines[i -1]:find("/*") then
			local todo = {}
			currLine = i
			while i <= #lines do
				table.insert(todo, lines[i])
				if lines[i]:find("*/") then
					i = i + 1
					break
				end
				i = i + 1
			end
			table.insert(todos, todo)
			table.insert(linePositions, currLine)
			currLine = -1
		else
			i = i + 1
		end
	end
	return todos, linePositions
end

--checks for all comments via treesitter if they contain TODO;
--it returns a array of text and corresponding line numbers of the comments
function M.parseWithTreesitter(_bufnr)
	local bufnr = _bufnr or 0
	local parser = vim.treesitter.get_parser(bufnr)
	local tree = parser:parse()[1]
	local root = tree:root()
	local todos = {}
	local linePositions = {}

	local function traverseTree(node)
		if node:type() == "comment" then
			local text = vim.treesitter.get_node_text(node, bufnr)
			if text:find("TODO") then
				local start_row, _, end_row, _ = node:range()
				table.insert(linePositions, {start_row, end_row})
				table.insert(todos, text)
			end
		end

		for child in node:iter_children() do
			traverseTree(child)
		end

	end
	traverseTree(root)
	return todos, linePositions
end

function M.collect()
	local todos, lines = M.parseWithTreesitter(0)
	if not todos or #todos == 0 or not lines or not #lines == 0 then
		print("no TODOS")
		return
	end
	local out = {}
	local header = {}
	local text = {}
	for idx, todo in ipairs(todos) do
		local head = string.format(
			"TODO %d - line %d - %d: ",
			idx,
			lines[idx][1],
			lines[idx][2]
		)
		table.insert(out, head)
		table.insert(header, head)

		for line in todo:gmatch("[^\r\n]+") do
			if line:match("TODO") then
				table.insert(text, line)
			end
		end
		for line in todo:gmatch("[^\r\n]+") do
			local cleaned = line:match("TODO:?%s*(.*)")
			if not cleaned then
				cleaned = line
			end
			cleaned = cleaned:gsub("//", "")
			cleaned = cleaned:gsub("/%*", "")
			cleaned = cleaned:gsub("%*/", "")
			cleaned = cleaned:match("^%s*(.-)%s*$")
			if not cleaned:match("%S") then
				goto continue
			end
			cleaned = ">>>	" .. cleaned
			table.insert(out, cleaned or line)
			::continue::
		end
		table.insert(out, "") -- separator
	end
	return out, header, text
end

return M
